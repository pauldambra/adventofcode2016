
class ElevatorIsFull < StandardError; end

class Elevator
  attr_reader :items
  
  def initialize(items=[])
    items = [items].flatten
    raise ElevatorIsFull, "only two items at a time", caller if items.length > 2
    @items = items
  end

  def load(item)
    new_contents = items + [item].flatten
    raise ElevatorIsFull, "only two items at a time", caller if new_contents.length > 2
    Elevator.new(new_contents)
  end
end