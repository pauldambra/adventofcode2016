
class GPS
  attr_reader :first_revisited_location

  def initialize
    @x = 0
    @y = 0
    @visited_coords = []
    @first_revisited_location = nil
  end

  def update_visited_coordinates(coords)
    if @visited_coords.include?(coords) then
      @first_revisited_location = coords if @first_revisited_location == nil
    end
    @visited_coords.push(coords)
  end

  def walk(direction, blocks)
    for i in 1..blocks
      coords = direction.walk([@x, @y])
      update_visited_coordinates coords
      @x = coords[0]
      @y = coords[1]
    end
  end

  def blocks_travelled
    @x.abs + @y.abs
  end

  def blocks_travelled_to_easter_bunny_hq
    @first_revisited_location[0].abs + @first_revisited_location[1].abs
  end
end