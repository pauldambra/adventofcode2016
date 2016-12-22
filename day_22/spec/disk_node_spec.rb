require_relative('../disk_node.rb')

describe "disknode" do
  it "can read the node name and position" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.new(input)
    expect(du.name).to eq 'node-x0-y2'
    expect(du.position).to eq [0,2]
  end

  it "can read used space" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.new(input)
    expect(du.used).to eq 70
  end

  it "can read available space" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.new(input)
    expect(du.available).to eq 23
  end

  it "can list nodes that have enough avail for another nodes used" do
    a = DiskNode.new '/dev/grid/node-x1-y2     90T   69T    21T   76%'
    b = DiskNode.new '/dev/grid/node-x1-y3     93T   19T    23T   75%'
    expect(a.has_space_for(b)).to eq true
    expect(b.has_space_for(a)).to eq false
  end

  it "can check if a node is not empty" do
    node = DiskNode.new '/dev/grid/node-x1-y2     90T   69T    21T   76%'
    expect(node.is_not_empty?).to eq true
  end

  it "can check if a node is empty" do
    node = DiskNode.new '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    expect(node.is_not_empty?).to eq false
    expect(node.is_empty?).to eq true
  end

  it "can compare two nodes" do
    node_a = DiskNode.new '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    node_b = DiskNode.new '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    expect(node_a).to eq node_b
  end

end