require_relative('../ipv7.rb')

# --- Day 7: Internet Protocol Version 7 ---

# While snooping around the local network of EBHQ, you compile a list of IP
# addresses (they're IPv7, of course; 
# IPv6 is much too limited). You'd like to figure out which IPs support TLS 
#(transport-layer snooping).

# An IP supports TLS if it has an Autonomous Bridge Bypass Annotation, or ABBA. 
# An ABBA is any four-character sequence which consists of a pair of two
# different characters 
# followed by the reverse of that pair, such as xyyx or abba. #
# However, the IP also must not have an ABBA within any hypernet sequences,
# which are contained by square brackets.

# For example:

# abba[mnop]qrst supports TLS (abba outside square brackets).
# abcd[bddb]xyyx does not support TLS (bddb is within square brackets, even
# though xyyx is outside square brackets).
# aaaa[qwer]tyui does not support TLS (aaaa is invalid; the interior characters
# must be different).
# ioxxoj[asdfgh]zxcvbn supports TLS (oxxo is outside square brackets, even
# though it's within a larger string).
# How many IPs in your puzzle input support TLS?



describe "day 7 part one" do
  describe "when processing the provided examples" do
    it "can id abba[mnop]qrst as TLS" do
      expect(IPV7.is_tls? "abba[mnop]wrst").to be true
    end
    it "can id abcd[bddb]xyyx as not TLS" do
      expect(IPV7.is_tls? "abcd[bddb]xyyx").to be false
    end
    it "can id aaaa[qwer]tyui as not TLS" do
      expect(IPV7.is_tls? "aaaa[qwer]tyui").to be false
    end
    it "can id ioxxoj[asdfgh]zxcvbn as TLS" do
      expect(IPV7.is_tls? "ioxxoj[asdfgh]zxcvbn").to be true
    end
  end

  it "can do some from puzzle input" do
    expect(IPV7.is_tls?('vjqhodfzrrqjshbhx[lezezbbswydnjnz]ejcflwytgzvyigz[hjdilpgdyzfkloa]mxtkrysovvotkuyekba')).to be true
    expect(IPV7.is_tls?('epmnxkubnsnyeeyubv[ydzhcoytayiqmxlv]edmbahbircojbkmrg[dlxyprugefqzkum]svdaxiwnnwlkrkukfg[eacekyzjchfpzghltn]ofwgevhoivrevueaj')).to be true
  end

  it "can count the TLS supporting IPs in the puzzle_input" do
    count = File.readlines(__dir__ + '/puzzle_input.txt')
                .map { |e| IPV7.is_tls?(e) }
                .select { |r| r }
                .count
    p "count of TLS supporting IPs is #{count}"
  end
end