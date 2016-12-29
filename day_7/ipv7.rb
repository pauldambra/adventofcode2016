class IPV7
  def self.is_tls?(address)
    candidate_abbas = split_into_overlapping_segments(address, 4)
           .select { |ca| ca[0] != ca[1] && ca[0] == ca[3] && ca[1] == ca[2] }
           .map { |cai| [cai,  is_outside_of_square_brackets?(cai, address) ] }
                             
    candidate_abbas.length > 0 && candidate_abbas.all? { |x| x[1] }
  end

# An IP supports SSL if it has an Area-Broadcast Accessor, 
# or ABA, anywhere in the supernet sequences (outside any 
# square bracketed sections), 
# and a corresponding Byte Allocation Block, 
# or BAB, anywhere in the hypernet sequences. 
# An ABA is any three-character sequence which consists 
# of the same character twice with a different character
# between them, such as xyx or aba. A corresponding BAB is the
# same characters but in reversed positions: yxy and bab,
# respectively.
  def self.supports_ssl?(address)

    candidates = supernet_sequences(address)
    candidates = find_abas(candidates)
    
    if candidates.empty?
      return {supports_ssl: false, address: address}
    end

    candidates = candidates.map { |candidate| hypernet_sequences(candidate) }
                           .map { |c| c[:bab] = toggle_bab_or_aba(c[:aba]); c }
                           .map do |c| 
                            c[:supports_ssl] = c[:hypernet_sequences].any? do |hs| 
                              hs.include? c[:bab]
                            end
                            c
                           end
    
    if candidates.any? { |c| c[:supports_ssl] }
      candidates.select { |c| c[:supports_ssl] }.first
    else
      # p "no ssl for #{candidates.inspect}"
      candidates.first
    end
  end

  def self.find_abas(candidate)
    haystack = candidate[:supernet_sequences]
    split_into_overlapping_segments(haystack, 3)
      .select { |ca| ca[0] != ca[1] && ca[0] == ca[2] }
      .map { |aba| h = candidate.clone; h[:aba] = aba; h }
  end

  def self.find_babs_in_square_braces(haystack)
    split_into_overlapping_segments(haystack, 3)
      .select { |ca| ca[0] != ca[1] && ca[0] == ca[2] }
      .reject { |ca| ca.include? '['}
      .reject { |ca| ca.include? ']'}
      .select { |bab| !is_outside_of_square_brackets?(bab, haystack) }
      .map { |bab| {bab: bab, address: haystack} }
  end

  def self.toggle_bab_or_aba(aba)
    candidate_bab = aba.chars[1] + aba.chars[0] + aba.chars[1]
  end

  def self.split_into_overlapping_segments(s, n)
    s.chomp.chars
     .map.with_index { |c, index| s.slice(index, n) }
     .select { |ca| ca.length == n }
  end

  def self.is_outside_of_square_brackets?(s, address)
    (/\[[^\]]*#{s}[^\[]*\]/ =~ address) == nil
  end

  def self.supernet_sequences(address)
    {address: address, supernet_sequences: address.gsub(/\[[^\]]*.*?[^\[]*\]/, '')}
  end

  def self.hypernet_sequences(candidate)
    hypernet_matches = candidate[:address].scan(/\[(.*?)\]/).flatten
    candidate[:hypernet_sequences] = hypernet_matches
    candidate
  end
end