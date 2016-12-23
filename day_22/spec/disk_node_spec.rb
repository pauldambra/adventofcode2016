require_relative('../disk_node.rb')

describe "disknode" do
  it "can read the node name and position" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.parse(input)
    expect(du.name).to eq 'node-x0-y2'
    expect(du.position).to eq [0,2]
  end

  it "can read used space" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.parse(input)
    expect(du.used).to eq 70
  end

  it "can read available space" do
    input = '/dev/grid/node-x0-y2     93T   70T    23T   75%'
    du = DiskNode.parse(input)
    expect(du.available).to eq 23
  end

  it "can list nodes that have enough avail for another nodes used" do
    a = DiskNode.parse '/dev/grid/node-x1-y2     90T   69T    21T   76%'
    b = DiskNode.parse '/dev/grid/node-x1-y3     93T   19T    23T   75%'
    expect(a.has_space_for(b)).to eq true
    expect(b.has_space_for(a)).to eq false
  end

  it "can check if a node is not empty" do
    node = DiskNode.parse '/dev/grid/node-x1-y2     90T   69T    21T   76%'
    expect(node.is_not_empty?).to eq true
  end

  it "can check if a node is empty" do
    node = DiskNode.parse '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    expect(node.is_not_empty?).to eq false
    expect(node.is_empty?).to eq true
  end

  it "can compare two nodes" do
    node_a = DiskNode.parse '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    node_b = DiskNode.parse '/dev/grid/node-x1-y2     90T   0T    21T   76%'
    expect(node_a).to eq node_b
  end

  it "can accept data from another disk" do
    node_a = DiskNode.parse '/dev/grid/node-x1-y2     90T   6T    21T   76%'
    node_b = DiskNode.parse '/dev/grid/node-x1-y2     90T   8T    21T   76%'
    node_a.take_data_from(node_b)
    
    expect(node_a.used).to eq 14
    expect(node_a.available).to eq 13

    expect(node_b.used).to eq 0
    expect(node_b.available).to eq 29
  end

  it "can clone nodes" do
    node_a = DiskNode.parse '/dev/grid/node-x1-y2     90T   6T    21T   76%'
    node_b = node_a.clone

    expect(node_a).not_to be node_b
    expect(node_a).to eq node_b

    expect(node_a.name).not_to be node_b.name
    expect(node_a.position).not_to be node_b.position
    
    expect(node_a.name).to eq node_b.name
    expect(node_a.position).to eq node_b.position

    node_a.used = 1
    expect(node_b.used).not_to eq 1

    node_a.available = 1
    expect(node_b.available).not_to eq 1
  end

end