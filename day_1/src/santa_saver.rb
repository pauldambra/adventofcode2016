require_relative('./compass_points.rb')
require_relative('./gps.rb')

class GridWalker

  def initialize
    @direction = North.new
    @gps = GPS.new
  end

  def blocks_travelled
    @gps.blocks_travelled.abs
  end

  def easter_bunny_location
    @gps.blocks_travelled_to_easter_bunny_hq
  end

  def walk(puzzle_input)
    puzzle_input.split(', ')
                .map { |ins| {direction: ins[0], steps: ins[1..-1].to_i}}
                .each do |ins|
                  @direction = ins[:direction] == 'R' ? @direction.right : @direction.left
                  @gps.walk(@direction, ins[:steps])
                end
  end

  def right(steps)
    @direction = @direction.right
    @blocks_travelled = update_steps(@blocks_travelled, steps)
  end

  def left(steps)
    @direction = @direction.left
    @blocks_travelled = update_steps(@blocks_travelled, steps)
  end

  def update_steps(current, change)
    current.send(@direction.modifier, change)
  end
end

class SantaSaver
  attr_reader :grid_walker

  def initialize
    @grid_walker = GridWalker.new
  end
end