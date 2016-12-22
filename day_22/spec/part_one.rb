require_relative('../disk_node.rb')
require_relative('../disk_pairer.rb')

# --- Day 22: Grid Computing ---

# You gain access to a massive storage cluster arranged in a grid; each storage
# node is only connected to the four nodes directly adjacent to it (three if
# the node is on an edge, two if it's in a corner).

# You can directly access data only on node /dev/grid/node-x0-y0, but you can
# perform some limited actions on the other nodes:

# You can get the disk usage of all nodes (via df). The result of doing this
# is in your puzzle input.
# You can instruct a node to move (not copy) all of its data to an adjacent
# node (if the destination node has enough space to receive the data).
# The sending node is left empty after this operation.
# Nodes are named by their position: the node named node-x10-y10 is adjacent
# to nodes node-x9-y10, node-x11-y10, node-x10-y9, and node-x10-y11.

# Before you begin, you need to understand the arrangement of data on these
# nodes. Even though you can only move data between directly connected nodes,
# you're going to need to rearrange a lot of the data to get access to the data
# you need. Therefore, you need to work out how you might be able to shift data
# around.

# To do this, you'd like to count the number of viable pairs of nodes. A viable
# pair is any two nodes (A,B), regardless of whether they are directly
# connected, such that:

# Node A is not empty (its Used is not zero).
# Nodes A and B are not the same node.
# The data on node A (its Used) would fit on node B (its Avail).
# How many viable pairs of nodes are there?

describe "day 22 - part one" do
  it "does not care about the order of disk pairs" do
    a = DiskPair.new(
      DiskNode.new('/dev/grid/node-x0-y0     89T   30T    35T   75%'),
      DiskNode.new('/dev/grid/node-x0-y1     89T   30T    35T   75%')
    )
    b = DiskPair.new(
      DiskNode.new('/dev/grid/node-x0-y1     89T   30T    35T   75%'),
      DiskNode.new('/dev/grid/node-x0-y0     89T   30T    35T   75%')
    )

    expect(a).to eq b
  end

  it "can have sets of pairs" do
    a = DiskPair.new(
      DiskNode.new('/dev/grid/node-x0-y0     89T   30T    35T   75%'),
      DiskNode.new('/dev/grid/node-x0-y1     89T   30T    35T   75%')
    )
    b = DiskPair.new(
      DiskNode.new('/dev/grid/node-x0-y1     89T   30T    35T   75%'),
      DiskNode.new('/dev/grid/node-x0-y0     89T   30T    35T   75%')
    )
    c = Set.new
    c.add(a)
    expect(c.add?(b)).to eq nil
  end

  it "can find pairs of nodes" do
    nodes = [
    '/dev/grid/node-x0-y0     89T   30T    22T   75%',
    '/dev/grid/node-x0-y1     91T   450T    19T   79%',
    '/dev/grid/node-x0-y2     93T   550T    23T   75%',
    '/dev/grid/node-x0-y3     90T   650T    26T   71%',
    '/dev/grid/node-x0-y4     87T   100T    10T   77%',
    '/dev/grid/node-x0-y5     92T   200T    12T   76%',
    '/dev/grid/node-x0-y6     92T   200T    16T   71%',
    '/dev/grid/node-x0-y7     86T   200T    16T   81%',
    '/dev/grid/node-x0-y8     89T   200T    31T   74%',
    '/dev/grid/node-x0-y9     91T   200T    42T   78%',
    '/dev/grid/node-x0-y10    87T   200T    53T   80%',
    '/dev/grid/node-x0-y11    89T   200T    63T   82%'
    ].map { |e| DiskNode.new e }

    expect(DiskPairer.new(nodes).pairs.map { |e| [e.left.name, e.right.name] }).to eq [
      ['node-x0-y0', 'node-x0-y8'],
      ['node-x0-y0', 'node-x0-y9'],
      ['node-x0-y0', 'node-x0-y10'],
      ['node-x0-y0', 'node-x0-y11']
    ]
  end

  it "only finds pairs once" do
    nodes = [
    '/dev/grid/node-x0-y0     89T   30T    62T   75%',
    '/dev/grid/node-x0-y1     91T   30T    79T   79%',
    ].map { |e| DiskNode.new e }

    expect(DiskPairer.new(nodes).pairs.map { |e| [e.left.name, e.right.name] }).to eq [
      ['node-x0-y0', 'node-x0-y1']
    ]
  end

  it "only finds pairs where node a is not empty" do
    a  = [
      DiskNode.new('/dev/grid/node-x0-y0     89T   0T    35T   75%'),
      DiskNode.new('/dev/grid/node-x0-y1     89T   0T    35T   75%')
    ]
    expect(DiskPairer.new(a).pairs).to be_empty
  end

  it "can find pairs in the puzzle input" do
    input = File.readlines(__dir__ + '/puzzle_input.txt')
                .select { |e| e.start_with? '/dev/grid' }
                .map(&:chomp)
                .map { |e| DiskNode.new e }
    dp = DiskPairer.new(input)
    p "pairer finds #{dp.pairs.length} pairs"
  end
end