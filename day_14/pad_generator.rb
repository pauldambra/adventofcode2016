require_relative('candidate_promoter.rb')
require_relative('hasheriser.rb')
require_relative('hash_checker.rb')

class PadGenerator
  def initialize(salt, hasher)
    @salt = salt
    @hasher = hasher
    @candidate_promoter = CandidatePromoter.new(1000)

    @candidate_keys = []
    @validated_keys = []
    @confirmed_keys = []
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
