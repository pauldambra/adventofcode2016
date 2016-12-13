# --- Day 13: A Maze of Twisty Little Cubicles ---

# You arrive at the first floor of this new building to discover
# a much less welcoming environment than the shiny atrium of the
# last one. Instead, you are in a maze of twisty little cubicles,
# all alike.

# Every location in this area is addressed by a pair of non-negative
# integers (x,y). Each such coordinate is either a wall or an open
# space. You can't move diagonally. The cube maze starts at 0,0 and
# seems to extend infinitely toward positive x and y; negative values
# are invalid, as they represent a location outside the building.
# You are in a small waiting area at 1,1.

# While it seems chaotic, a nearby morale-boosting poster explains,
# the layout is actually quite logical. You can determine whether
# a given x,y coordinate will be a wall or an open space using a
# simple system:

# Find x*x + 3*x + 2*x*y + y + y*y.
# Add the office designer's favorite number (your puzzle input).
# Find the binary representation of that sum; count the number of
# bits that are 1.
# If the number of bits that are 1 is even, it's an open space.
# If the number of bits that are 1 is odd, it's a wall.
# For example, if the office designer's favorite number were 10,
# drawing walls as # and open spaces as ., the corner of the
# building containing 0,0 would look like this:

#   0123456789
# 0 .#.####.##
# 1 ..#..#...#
# 2 #....##...
# 3 ###.#.###.
# 4 .##..#..#.
# 5 ..##....#.
# 6 #...##.###
# Now, suppose you wanted to reach 7,4. The shortest route you could
# take is marked as O:

#   0123456789
# 0 .#.####.##
# 1 .O#..#...#
# 2 #OOO.##...
# 3 ###O#.###.
# 4 .##OO#OO#.
# 5 ..##OOO.#.
# 6 #...##.###
# Thus, reaching 7,4 would take a minimum of 11 steps (starting
# from your current location, 1,1).

# What is the fewest number of steps required for you to reach 31,39?

# puzzle input is 1352

class Array
  def wall_or_space(favourite_number)
    x = self[0]
    y = self[1]
    sum = x*x + 3*x + 2*x*y + y + y*y + favourite_number
    binary = to_binary(sum)
    binary.count {|x| x==1} % 2 == 0 ? :space : :wall
  end

  private 

  def to_binary(n)
    return "0" if n == 0

    r = []

    32.times do
      if (n & (1 << 31)) != 0
        r << 1
      else
        (r << 0) if r.size > 0
      end
      n <<= 1
    end

    r
  end
end

describe "day 13 part one" do
  it "can check if a coordinate is a wall" do
    # first two columns
    expect([0,0].wall_or_space(10)).to eq :space
    expect([0,1].wall_or_space(10)).to eq :space
    expect([0,2].wall_or_space(10)).to eq :wall
    expect([0,3].wall_or_space(10)).to eq :wall
    expect([0,4].wall_or_space(10)).to eq :space
    expect([0,5].wall_or_space(10)).to eq :space
    expect([0,6].wall_or_space(10)).to eq :wall
    expect([1,0].wall_or_space(10)).to eq :wall
    expect([1,1].wall_or_space(10)).to eq :space
    expect([1,2].wall_or_space(10)).to eq :space
    expect([1,3].wall_or_space(10)).to eq :wall
    expect([1,4].wall_or_space(10)).to eq :wall
    expect([1,5].wall_or_space(10)).to eq :space
    expect([1,6].wall_or_space(10)).to eq :space
  end  
end




