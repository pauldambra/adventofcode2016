require_relative('../ipv7.rb')

# --- Day 7 Part Two ---

# You would also like to know which IPs support SSL 
# (super-secret listening).

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

# For example:

# aba[bab]xyz supports SSL 
   #(aba outside square brackets with corresponding 
   #bab within square brackets).
# xyx[xyx]xyx does not support SSL 
    #(xyx, but no corresponding yxy).
# aaa[kek]eke supports SSL 
    #(eke in supernet with corresponding kek in hypernet; 
    #the aaa sequence is not related, because the interior
    # character must be different).
# zazbz[bzb]cdb supports SSL 
    #(zaz has no corresponding aza, 
    #but zbz has a corresponding bzb, 
    #even though zaz and zbz overlap).
# How many IPs in your puzzle input support SSL?

describe "day 7 part two" do
  describe "when processing the provided examples" do
    it "can aba[bab]xyz" do
      expect(IPV7.supports_ssl? "aba[bab]xyz").to be true  
    end

    it "can xyx[xyx]xyx" do 
      expect(IPV7.supports_ssl? 'xyx[xyx]xyx').to be false
    end

    it "can aaa[kek]eke" do
      expect(IPV7.supports_ssl? 'aaa[kek]eke').to be true
    end
    it "can zazbz[bzb]cdb" do
      expect(IPV7.has_aba? 'zazbz[bzb]cdb').to be true
      expect(IPV7.has_bab_anywhere? 'bzb', 'zazbz[bzb]cdb').to be true
      expect(IPV7.has_bab_inside_square_brackets? 'bzb', 'zazbz[bzb]cdb').to be true
      expect(IPV7.supports_ssl? 'zazbz[bzb]cdb').to be true
    end 

    it "can ottpscfbgoiyfri[iwzhojzrpzuinumuwd]orfroqlcemumqbqqrea" do
      input = 'ottpscfbgoiyfri[iwzhojzrpzuinumuwd]orfroqlcemumqbqqrea'
      expect(IPV7.has_aba? input).to be true
      expect(IPV7.has_bab_anywhere? 'umu', input).to be true
      expect(IPV7.has_bab_inside_square_brackets? 'umu', input).to be true
      expect(IPV7.supports_ssl? input).to be true
    end
  end

  it "can count the SSL supporting IPs in the puzzle_input" do
    count = File.readlines(__dir__ + '/puzzle_input.txt')
                .map(&:chomp)
                # .tap { |l| p "there are #{l.length} addresses"}
                .select { |l| IPV7.has_aba?(l) }
                # .tap { |l| p "#{l.length} have an aba"}
                .map { |l| IPV7.find_abas(l) }
                .flatten
                # .tap { |l| p "each string can have more than one so there are #{l.length} candidates"}
                .map { |l| l[:bab] = IPV7.to_bab(l[:aba]); l }
                # .tap { |l| log_file('1-with-babs.txt', l)}
                .select do |l| 
                  IPV7.has_bab_anywhere?(l[:bab], l[:address]) 
                end
                # .tap { |l| p "#{l.length} have a bab anywhere"}
                # .tap { |l| log_file('2-bab-in-address.txt', l)}
                .select { |l| IPV7.has_bab_inside_square_brackets?(l[:bab], l[:address]) }
                # .tap { |l| p "#{l.length} have a bab inside square brackets"}
                # .tap { |l| log_file('3-bab-in-squares-address.txt', l)}
                .map { |e| IPV7.supports_ssl?(e[:address]) }
                .select { |r| r }
                .count
    p "count of SSL supporting IPs is #{count}"
  end

  def log_file(path, content)
    File.open("./#{path}", 'w') do |file|  
      content.each {|c| file.puts c }
    end
  end
end