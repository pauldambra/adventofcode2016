require_relative('../firewall.rb')

# --- Day 20: Firewall Rules ---

# You'd like to set up a small hidden computer here so you can use it
# to get back into the network later. However, the corporate firewall
# only allows communication with certain external IP addresses.

# You've retrieved the list of blocked IPs from the firewall, but
# the list seems to be messy and poorly maintained, and it's not
# clear which IPs are allowed. Also, rather than being written
# in dot-decimal notation, they are written as plain 32-bit integers,
# which can have any value from 0 through 4294967295, inclusive.

# For example, suppose only the values 0 through 9 were valid,
# and that you retrieved the following blacklist:

# 5-8
# 0-2
# 4-7
# The blacklist specifies ranges of IPs (inclusive of both the start
# and end value) that are not allowed. Then, the only IPs that this
# firewall allows are 3 and 9, since those are the only numbers not
# in any range.

# Given the list of blocked IPs you retrieved from the firewall
# (your puzzle input), what is the lowest-valued IP that is not
# blocked?

describe "day 20 - part one" do
  it "can find a number not in a range" do
    a = '0-2'
    b = '4-6'
    expect(Firewall.new(6).lowest_allowed_ip([a,b])).to eq 3
  end

  it "can find a number not in the example range" do
    ranges = %{5-8
    0-2
    4-7}
    expect(Firewall.new(9).lowest_allowed_ip(ranges.lines)).to eq 3
  end

  it "can solve the puzzle input" do
    ranges = File.readlines(__dir__ + '/puzzle_input.txt')
    n = Firewall.new(4294967295)
    min = n.lowest_allowed_ip(ranges)
    p "min val in puzzle_input.txt is #{min}"
  end
end

# --- Part Two ---

# How many IPs are allowed by the blacklist?
describe "day 20 - part two" do
  it "can count allowed IPs" do
    ranges = [
      '1-4',
      '2-6',
      '8-10',
      '12-14',
      '16-20'
    ]
    n= Firewall.new(20)
    expect(n.allowed_ips(ranges)).to eq [0,7,11,15]
  end

  it "can solve the puzzle input" do
    ranges = File.readlines(__dir__ + '/puzzle_input.txt')
    n = Firewall.new(4294967295)
    allowed_ips_count = n.allowed_ips(ranges).length
    p "count of allowed ips is #{allowed_ips_count}"
  end
end