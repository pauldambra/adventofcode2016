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
    it "has no aba" do
      r = IPV7.supports_ssl? "aaa[bab]xxz"
      expect(r[:supports_ssl]).to be false
    end
    it "can aba[bab]xyz" do
      r = IPV7.supports_ssl? "aba[bab]xyz"
      expect(r[:supports_ssl]).to be true
    end

    it "can xyx[xyx]xyx" do 
      r = IPV7.supports_ssl? 'xyx[xyx]xyx'
      expect(r[:supports_ssl]).to be false
    end

    it "can aaa[kek]eke" do
      r = IPV7.supports_ssl? 'aaa[kek]eke'
      expect(r[:supports_ssl]).to be true
    end
    it "can zazbz[bzb]cdb" do
      r = IPV7.supports_ssl? 'zazbz[bzb]cdb'
      expect(r[:supports_ssl]).to be true
    end 

    it "can ottpscfbgoiyfri[iwzhojzrpzuinumuwd]orfroqlcemumqbqqrea" do
      input = 'ottpscfbgoiyfri[iwzhojzrpzuinumuwd]orfroqlcemumqbqqrea'
      r = IPV7.supports_ssl? input
      expect(r[:supports_ssl]).to be true
    end
  end

  it "can count the SSL supporting IPs in the puzzle_input" do
    my_passes = File.readlines(__dir__ + '/puzzle_input.txt')
                .map(&:chomp)
                .map { |e| IPV7.supports_ssl?(e) }
                .flatten
                .select { |r| r[:supports_ssl] == true }

    p "count of SSL supporting IPs is #{my_passes.count}"
  end
end