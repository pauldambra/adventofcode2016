
class Floor
  attr_reader :number
  attr_reader :items
  attr_reader :elevator

  def initialize(number, elevator = nil, items=[])
    @number = number
    @items = [items].flatten
    @elevator = elevator
  end

  def unload(item)
    elvtr = Elevator.new(@elevator.items - [item])
    Floor.new(@number, elvtr, @items + [item].flatten)
  end

  def load(item)
    new_items = @items - [item]
    elvtr = @elevator.load(item)
    Floor.new(@number, elvtr, new_items)
  end

  def is_valid?
    # in order to be invalid there must be at least one chip
    # and at least one generator and they aren't for the same
    # material
    # i.e. every generator must have a matching chip 

    items = all_items

    return true if items.count <= 1
    return true unless items.any? { |e| e.is_a? Generator }

    # An RTG powering a microchip is still dangerous to other microchips.
    return microchips.all? { |m| generators().any? { |g|  m.element == g.element } }
  end

  def to_output
    "F#{@number} #{@elevator ? 'E' : ''} " + all_items.map(&:to_output).join(' ')
  end

  def has_elevator?
    @elevator != nil
  end

  private 

  def generators
    all_items.select { |i| i.is_a? Generator }
  end

  def microchips
    all_items.select { |i| i.is_a? Microchip }
  end

  def all_items
    @items + (@elevator ? @elevator.items : [])
  end
end