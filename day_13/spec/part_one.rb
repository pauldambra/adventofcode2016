require_relative('../node.rb')

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

require 'timeout'

RSpec.configure do |c|
  c.around(:each) do |example|
    Timeout::timeout(10) {
      example.run
    }
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

  it "can build two steps" do
    start = [1,1]

    Node.favourite_number = 10
    root = Node.new(start, 0) 
    root.expand
    root.children.each { |e| e.expand }

    # generates
    # 0,1 => space <--
    # 2,1 => wall
    # 1,0 => wall
    # 1,2 => space <--
    # so [[0,1], [1,2]]

    # [-1, 1] => invalid
    # [1, 1] => already
    # [0,2] => wall
    # [0,0] => space <--

    # [0,2] => already
    # [2,2] => space <--
    # [1,3] => wall
    # [1,1] => already

    expect(root.children.count).to eq 2
    expect(root.children.all? {|c| c.step == 1})
    expect(root.children.map { |e| e.coord }).to eq [[0,1], [1,2]]

    expect(root.children
               .map { |e| e.children }
               .flatten
               .map { |e| e.coord }).to eq [[0,0], [2,2]]
    expect(root.children
               .map { |e| e.children }
               .flatten
               .all? { |e| e.step == 2}).to eq true
  end

  it "can stop at a target" do
    start = [1,1]
    target = [3,3]
    Node.favourite_number = 10
    final_node = Node.steps_between(start, target)
    expect(final_node.step).to eq 4
  end

  it "can solve the example input" do
    start = [1,1]
    target = [7,4]
    Node.favourite_number = 10
    final_node = Node.steps_between(start, target)
    expect(final_node.step).to eq 11
  end

  it "can solve the puzzle input" do
    start = [1,1]
    target = [31,39]
    Node.favourite_number = 1352
    final_node = Node.steps_between(start, target)
    p "node #{final_node.coord} took #{final_node.step} steps"
  end
end




