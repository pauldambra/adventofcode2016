require_relative('../node.rb')

# --- Part Two ---

# How many locations (distinct x,y coordinates, including your
# starting location) can you reach in at most 50 steps?

# Your puzzle input is still 1352.

describe "day 13 part two" do
  it "can find everything within two steps" do
    start = [1,1]

    Node.favourite_number = 10
    count = Node.nodes_within(start, 2)

    expect(count).to be 5
  end

  it "can find everything within 50 steps" do
    start = [1,1]

    Node.favourite_number = 1352
    count = Node.nodes_within(start, 50)

    p "that means there are #{Node.traversed_nodes.uniq.count} within 50 steps"
  end
end