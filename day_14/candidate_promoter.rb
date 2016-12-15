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