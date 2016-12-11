require_relative('./item.rb')

class ElevatorMustHaveContents < StandardError; end

class RadioisotopeTestingFacility
  attr_reader :floors

  def initialize(floors)
    @floors = [floors].flatten

    puts show + "\n---------\nis valid?: #{is_valid?}\n---------"
  end

  def load_item_from_floor_to_elevator(*item, floor_number)
    floors = Marshal.load(Marshal.dump(@floors))
    f = floors[floor_number]
    item.each { |i| f = f.load(i) }
    floors[floor_number] = f
    RadioisotopeTestingFacility.new(floors)
  end

  def elevator_goes_to_floor(old, new)
    elevator = @floors[old].elevator.clone
    raise ElevatorMustHaveContents if elevator.items.empty?

    floors = @floors.map { |f| 
      elvtr = f.number == new ? elevator : nil
      Floor.new(f.number, elvtr, f.items.clone)
    }
    RadioisotopeTestingFacility.new(floors)
  end

  def elevator_goes(direction)
    modifier = direction == :up ? 1 : -1
    current_floor = @floors.select { |f| f.has_elevator? }[0].number
    new_floor = current_floor + modifier
    elevator_goes_to_floor(current_floor, new_floor)
  end

  def steps_to_solution
    -1
  end

  def is_valid?
    @floors.all? { |f| f.is_valid? }
  end

  def show
    @floors.reverse.map { |f| f.to_output }.join("\n")
  end
end
