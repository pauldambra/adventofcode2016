class IPV7
  def self.is_tls?(address)
    candidate_abbas = split_into_overlapping_segments(address, 4)
                             .select { |ca| ca[0] != ca[1] && ca[0] == ca[3] && ca[1] == ca[2] }
                             .map { |cai| [cai,  is_outside_of_square_brackets(cai, address) ] }
                             
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
    abas = find_abas(address)

    return false if abas.empty?

    abas.any? do |found_aba|
      aba = found_aba[:aba]

      candidate_bab = to_bab(aba)
      
      bab_present = has_bab_anywhere? candidate_bab, address
      next if !bab_present

      bab_present_and_valid = has_bab_inside_square_brackets?(candidate_bab, address)
      if !bab_present_and_valid

        a = address.gsub(/\[/,  "\e[44m\[\e[0m")
        a = a.gsub(/\]/,  "\e[44m\]\e[0m")
        # a = a.gsub(/#{candidate_bab}/, "\e[42m#{candidate_bab}\e[0m")
        a = a.gsub(/#{aba}/, "\e[41m#{aba}\e[0m")
        
        p "---------------------------------"
        p "address: #{address}"
        p "aba: #{aba}"
        p "bab: #{candidate_bab}"
        puts a
        p "bab #{candidate_bab} is present? #{bab_present}"
        p "but not discovered in square braces"
        p "---------------------------------"
      end
      bab_present_and_valid
    end
  end

  def self.has_aba?(s)
    !find_abas(s).empty?
  end

  def self.find_abas(haystack)
    split_into_overlapping_segments(haystack, 3)
      .select { |ca| ca[0] != ca[1] && ca[0] == ca[2] }
      .reject { |ca| ca.include? '['}
      .reject { |ca| ca.include? ']'}
      .select { |aba| is_outside_of_square_brackets(aba, haystack) }
      .map { |aba| {aba: aba, address: haystack} }
  end

  def self.to_bab(aba)
    candidate_bab = aba.chars[1] + aba.chars[0] + aba.chars[1]
  end

  def self.has_bab_anywhere?(bab, address)
    (/#{bab}/ =~ address) != nil
  end

  def self.has_bab_inside_square_brackets?(bab, address)
    !is_outside_of_square_brackets(bab, address)
  end

  def self.split_into_overlapping_segments(s, n)
    s.chomp.chars
     .map.with_index { |c, index| s.slice(index, n) }
     .select { |ca| ca.length == n }
  end

  def self.is_outside_of_square_brackets(s, address)
    (/\[[^\]]*#{s}[^\[]*\]/ =~ address) == nil
  end
end