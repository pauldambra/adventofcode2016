require 'digest'

class Hasheriser
  def make(salt, index)
    get_hash("#{salt}#{index}")
  end

  def get_hash(s)
    Digest::MD5.hexdigest(s)
  end
end

class StretchingHasheriser
  def initialize
    @hasher = Hasheriser.new
  end

  def make(salt, index)
    h = "#{salt}#{index}"
    for i in 0..2016
      h = @hasher.get_hash(h)
    end
    h
  end
end

class HashChecker
  def self.has_three_repeated_characters(h)
    repeated_sequence = /([0-9a-z])\1\1/.match h
    if repeated_sequence then
      matched_character = repeated_sequence.to_a[1]
    else
      nil
    end
  end

  def self.has_five_repeated(h, c)
    /(#{c})\1\1\1\1/.match h
  end
end

class CandidatePromoter
  def initialize(to_consider)
    @to_consider = to_consider
  end

  def check(candidate_keys, generated_hash, index)
    candidate_keys.map do |candidate|
        candidate[:expired] = index > @to_consider + candidate[:index] 
        next if candidate[:expired]
        next if candidate[:index] == index # don't check self
        repeated_sequence = HashChecker.has_five_repeated(generated_hash, candidate[:character])
        next unless repeated_sequence
        
        candidate.clone
      end
      .reject { |x| x == nil }
  end
end

class PadGenerator
  def initialize(salt, hasher)
    @salt = salt
    @candidate_keys = []
    @validated_keys = []
    @confirmed_keys = []
    @hasher = hasher

    @candidate_promoter = CandidatePromoter.new(1000)
  end

  def GetSixtyFourKeys
    index = 0

    while @confirmed_keys.length < 64
      current_index_hash = @hasher.make(@salt, index)
      store_candidates(current_index_hash, index)
      
      promoted_candidates = @candidate_promoter.check(@candidate_keys, current_index_hash, index)
      @validated_keys.push(promoted_candidates) unless promoted_candidates.empty?
      update_confirmed_keys

      if index%1000==0
        p "processing #{index}. found #{@confirmed_keys.length}" 

        prune_early_expired_candidate_keys
      end
      index += 1
    end
    
    @confirmed_keys
  end

  private 

  def prune_early_expired_candidate_keys
    while @candidate_keys[0] != nil && @candidate_keys[0][:expired]
      @candidate_keys.shift
    end
  end

  def store_candidates(generated_hash, index)
    character = HashChecker.has_three_repeated_characters(generated_hash)
    
    if character then
      @candidate_keys.push({
        index: index, 
        character: character, 
        hash: generated_hash
      })
    end
  end

  def update_confirmed_keys
    return if @validated_keys.empty?

    @confirmed_keys = @validated_keys
                      .flatten
                      .select { |vk| earlier_candidates(vk) }
                      .sort_by { |vk| vk[:index] }
  end

  def earlier_candidates(vk)
    @candidate_keys
        .select { |ck| ck[:index] < vk[:index] }
        .all? { |ck| ck[:expired] }
  end
end
