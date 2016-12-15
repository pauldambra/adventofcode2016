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