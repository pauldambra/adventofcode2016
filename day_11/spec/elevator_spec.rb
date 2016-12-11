require_relative('../elevator.rb')

describe "elevator" do
  it "can start with no items" do
    e = Elevator.new()
    expect(e.items).to eq []
  end
  
  it "can start with one item" do
    e = Elevator.new(['a'])
    expect(e.items).to eq ['a']
  end

  it "can start with two items" do
    e = Elevator.new(['a', 'b'])
    expect(e.items).to eq ['a', 'b']
  end

  it "cannot have more than two items" do
    e = Elevator.new(['a', 'b'])
    expect{e.load('c')}.to raise_error(ArgumentError)
  end

  it "returns a new elevator when loading items" do
    e = Elevator.new(['a'])
    e1 = e.load('b')
    expect(e).not_to be e1
  end
end