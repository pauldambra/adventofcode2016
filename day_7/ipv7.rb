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

    abas.any? do |aba|  
      candidate_bab = aba.chars[1] + aba.chars[0] + aba.chars[1]
      # p "looking for #{candidate_bab} in #{address}"
      # r = has_bab(candidate_bab, address)
      # p "has_bab? #{r}"
      bab_present = /#{candidate_bab}/ =~ address
      bab_present_and_valid = has_bab(candidate_bab, address)

      # if (bab_present && !bab_present_and_valid)
      #   p "---------------------------------"
      #   p "for #{address}"
      #   p "bab #{candidate_bab} is present"
      #   p "but not discovered in square braces"
      #   p "---------------------------------"
      # end
      bab_present_and_valid
    end
  end

  private

  def self.find_abas(haystack)
    split_into_overlapping_segments(haystack, 3)
      .select { |ca| ca[0] != ca[1] && ca[0] == ca[2] }
      .reject { |ca| ca.include? '['}
      .reject { |ca| ca.include? ']'}
      .select { |aba| is_outside_of_square_brackets(aba, haystack) }
  end

  def self.has_bab(bab, address)

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