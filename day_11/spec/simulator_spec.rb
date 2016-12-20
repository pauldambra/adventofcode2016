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

    root = Node.new(nil)
    root.add_child(Node.new(@facility))

    breadth_first_search(root)

    

    

    root
  end

  def breadth_first_search(parent)
    p "bfs!"

    parent.children.each do |c| 
      if c.facility.is_complete?
        break
      end
      generate_states(c)
      breadth_first_search(c)
    end

  end

  def generate_states(parent)
    begin
      p parent
      current_floor = parent.facility.floors.select {|f| f.has_elevator? }[0]
      unless current_floor.elevator.items.empty?
         p "unload each and both then go up, as new children"

         current_floor.elevator.items.each do |item|
          new_facility =  parent.facility.unload_item_from_elevator_to_floor item, current_floor.number
          new_facility = new_facility.elevator_goes :up

          if new_facility.is_valid?
            parent.add_child(Node.new(new_facility))
          end
         end

         # if elevator is full also unload everything as anew state and see if it 
         # works better next time?!
         if current_floor.elevator.items.count == 2 then
          new_facility =  parent.facility.unload_item_from_elevator_to_floor current_floor.elevator.items[0], current_floor.elevator.items[1], current_floor.number

          if new_facility.is_valid?
            parent.add_child(Node.new(new_facility))
          end
         end
      end

      unless current_floor.items.empty?
        current_floor.items.each do |item|
          p "adding an item for #{item.element}"

          new_facility = parent.facility.load_item_from_floor_to_elevator(item, current_floor.number)
          new_facility = new_facility.elevator_goes :up

          if new_facility.is_valid?
            parent.add_child(Node.new(new_facility))
          end
        end

        p "adding all pairs"
        current_floor.items.combination(2).each do |pair|

          new_facility = parent.facility.load_item_from_floor_to_elevator(pair[0], pair[1], current_floor.number)
          new_facility = new_facility.elevator_goes :up

          if new_facility.is_valid?
            parent.add_child(Node.new(new_facility))
          end
        end

      end


      p "going up with no change"
      new_facility = parent.facility.elevator_goes :up
      p "is valid no change move? #{new_facility.is_valid?}"
      if new_facility.is_valid?
        parent.add_child(Node.new(new_facility))
      end
    rescue ElevatorMustHaveContents
      # swallow
    rescue ElevatorIsFull
      # swallow
    end
  end
end

describe "a simulator" do

#                     /----Both up
#                    /
# root---------------\---- Chip B up
#  |                  \
#  empty so            chip A up-------
# cannot go
  xit "can simulate 2 new states after 1 step" do
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
  xit "can simulate 2 new states after 1 step starting with 3 chips" do
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
    # puts possibilities.children.map { |e| e.facility.show + "\n---------" }

    expect(possibilities.children.length).to eq 6
  end

  xit "can prune invalids states as it goes" do
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
    puts possibilities.children.map { |e| e.facility.show + "\n---------" }

    expect(possibilities.children.length).to eq 6
  end

  xit "can take two steps" do
    elevator = Elevator.new
    chip_a = Microchip.new(:uranium)
    gen_a = Generator.new(:uranium)
    chip_b = Microchip.new(:titanium)
    gen_b = Generator.new(:titanium)
    one = Floor.new(0)
    two = Floor.new(1)
    three = Floor.new(2, elevator, [chip_a, gen_a, chip_b, gen_b])
    four = Floor.new(3)
    floors = [one, two, three, four]
    facility = RadioisotopeTestingFacility.new(floors)

    simulator = Simulator.new
    possibilities = simulator.for(facility).take(2)

    p "test output"
    puts possibilities.children.map { |e| e.facility.show + "\n---------" }

    possibilities.children.each { |c| p c.children.count }

    expect(possibilities.children.all? { |e| e.children.count == 1 }).to eq true
  end

  xit "knows when it is complete" do

    elevator = Elevator.new
    chip_a = Microchip.new(:uranium)
    gen_a = Generator.new(:uranium)
    chip_b = Microchip.new(:titanium)
    gen_b = Generator.new(:titanium)
    one = Floor.new(0)
    two = Floor.new(1)
    three = Floor.new(2, elevator, [chip_a, gen_a, chip_b, gen_b])
    four = Floor.new(3)
    floors = [one, two, three, four]
    facility = RadioisotopeTestingFacility.new(floors)

    simulator = Simulator.new
    possibilities = simulator.for(facility).take(1)
 
    p "test output"
    puts possibilities.children.map { |e| e.facility.show + "\n---------" }
   
    expect(possibilities.children.count { |p| p.is_complete? }).to eq 1
  end
end







