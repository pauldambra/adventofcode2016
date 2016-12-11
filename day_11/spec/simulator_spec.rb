require_relative('../elevator.rb')
require_relative('../item.rb')
require_relative('../floor.rb')
require_relative('../radioisotope_testing_facility.rb')

class Node
  attr_reader :facility
  attr_reader :children

  def initialize(facility)
    @facility = facility
    @facility.freeze

    @children = []
  end

  def add_child(child)
    @children.push(child)
  end
end

class Simulator
  def for(facility)
    @facility = facility

    self
  end
  def take(steps)
    # find floor with elevator
    # can you load?
    # can you unload?
    # then go up
    # children are any valid states from those permuations

    root = Node.new(@facility)

    current_floor = @facility.floors.select {|f| f.has_elevator? }[0]
    unless current_floor.elevator.items.empty?
       p "unload each and both then go up, as new children"
    end

    unless current_floor.items.empty?
      current_floor.items.each do |item|
        p "adding an item for #{item.element}"

        new_facility = @facility.load_item_from_floor_to_elevator(item, current_floor.number)
        new_facility = new_facility.elevator_goes :up

        if new_facility.is_valid?
          root.add_child(new_facility)
        end
      end

      p "adding all pairs"
      current_floor.items.combination(2).each do |pair|

        new_facility = @facility.load_item_from_floor_to_elevator(pair[0], pair[1], current_floor.number)
        new_facility = new_facility.elevator_goes :up

        if new_facility.is_valid?
          root.add_child(new_facility)
        end
      end

    end

    begin
      p "going up with no change"
      new_facility = @facility.elevator_goes :up
      p "is valid no change move? #{new_facility.is_valid?}"
      if new_facility.is_valid?
        root.add_child(new_facility)
      end
    rescue ElevatorMustHaveContents
      # swallow
    end

    root
  end
end

describe "a simulator" do

#                     /----Both up
#                    /
# root---------------\---- Chip B up
#  |                  \
#  empty so            chip A up-------
# cannot go
  it "can simulate 2 new states after 1 step" do
    elevator = Elevator.new
    chip_a = Microchip.new(:uranium)
    chip_b = Microchip.new(:titanium)
    one = Floor.new(0, elevator, [chip_a, chip_b])
    two = Floor.new(1)
    facility = RadioisotopeTestingFacility.new([one, two])

    simulator = Simulator.new
    possibilities = simulator.for(facility).take(1)

    expect(possibilities.children.length).to eq 3
  end

#         B and C up
  #                \  /----Chip C up
#                   \/
# root---------------\---- Chip B up
#  |                /|\
#  empty so        / | chip A up
# cannot go       /  |
#                /    \
#       A and B up    A and C up
  it "can simulate 2 new states after 1 step starting with 3 chips" do
    elevator = Elevator.new
    chip_a = Microchip.new(:uranium)
    chip_b = Microchip.new(:titanium)
    chip_c = Microchip.new(:deuterium)
    one = Floor.new(0, elevator, [chip_a, chip_b, chip_c])
    two = Floor.new(1)
    facility = RadioisotopeTestingFacility.new([one, two])

    simulator = Simulator.new
    possibilities = simulator.for(facility).take(1)

    # p "test output"
    # puts possibilities.children.map { |e| e.show + "\n---------" }

    expect(possibilities.children.length).to eq 6
  end

  it "can prune invalids states as it goes" do
    elevator = Elevator.new
    chip_a = Microchip.new(:uranium)
    gen_a = Generator.new(:uranium)
    chip_b = Microchip.new(:titanium)
    gen_b = Generator.new(:titanium)
    one = Floor.new(0, elevator, [chip_a, gen_a, chip_b, gen_b])
    two = Floor.new(1)
    facility = RadioisotopeTestingFacility.new([one, two])

    simulator = Simulator.new
    possibilities = simulator.for(facility).take(1)

    p "test output"
    puts possibilities.children.map { |e| e.show + "\n---------" }

    expect(possibilities.children.length).to eq 6
  end
end







