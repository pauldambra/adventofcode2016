
class Step
  attr_reader :coordinate
  attr_accessor :passage_content
  attr_accessor :numbers_still_to_reach

  def initialize(coordinate)
    @coordinate = coordinate
  end

  def ==(other)
    coordinate[0] == other.coordinate[0] &&
    coordinate[1] == other.coordinate[1] &&
    numbers_still_to_reach == other.numbers_still_to_reach
  end

  def eql?(other)
    self == other
  end

  def hash
    [coordinate, numbers_still_to_reach].hash
  end
end