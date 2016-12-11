class Item
  attr_reader :element

  def initialize(element)
    @element = element
  end

  def to_output
    "#{@element.to_s.chars[0].upcase}#{@description}"
  end

  def ==(other)
    other.instance_of?(self.class) && state == other.state
  end
  alias_method :eql?, :==

  def state
    [@element, @description]
  end

  def hash
   state.hash
  end
end

class Microchip < Item
  def initialize(element)
    super(element)
    @description = 'M'
  end
end

class Generator < Item
  def initialize(element)
    super(element)
    @description = 'G'
  end
end