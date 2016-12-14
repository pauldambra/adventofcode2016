require 'digest'

class PadGenerator
  def initialize(salt)
    @salt = salt
    @candidate_keys = []
    @validated_keys = []
    @confirmed_keys = []
  end

  def GetSixtyFourKeys


    index = 0

    while @confirmed_keys.length < 65
      p "processing #{index}. found #{@confirmed_keys.length}" if index%300==0
      current_index_hash = make_key(index)
      store_candidates(current_index_hash, index)
      promote_candidates(current_index_hash, index)
      update_confirmed_keys

      index += 1
    end
    
    @confirmed_keys
  end

  private 

  def make_key(index)
    md5 = Digest::MD5.new
    md5 << "#{@salt}#{index}"
    md5.hexdigest
  end

  def store_candidates(generated_hash, index)
    repeated_sequence = /([0-9a-z])\1\1/.match generated_hash

    if repeated_sequence then
      matched_character = repeated_sequence.to_a[1]
      @candidate_keys.push({index: index, character: matched_character, hash: generated_hash})
    end
  end

  def promote_candidates(generated_hash, index)
    @candidate_keys.each_index
                  .select do |i| 
                    index > 1000 + @candidate_keys[i][:index] 
                  end
                  .each do |i|
                    @candidate_keys[i][:expired] = true
                  end

    @candidate_keys
      .reject { |ck| ck[:expired]}
      .each.with_index do |candidate, index|
        repeated_sequence = /(#{candidate[:character]})\1\1\1\1/.match generated_hash
        next unless repeated_sequence
        @validated_keys.push candidate.clone
      end
  end

  def update_confirmed_keys
    return if @validated_keys.empty?

    @confirmed_keys = @validated_keys
                      .select do |vk| 
                        @candidate_keys.select{ |ck| ck[:index] < vk[:index] }
                                       .all? { |ck| ck[:expired] }
                      end
                      .sort_by { |vk| vk[:index] }
  end
end