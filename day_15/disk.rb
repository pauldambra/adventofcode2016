
class Disk
  attr_reader :times_for_position_0

  def initialize(number_of_positions, starting_position)
    @number_of_positions = number_of_positions
    @positions = *(0..number_of_positions - 1)
    @starting_position = starting_position
    @positions = @positions.rotate(starting_position)

    @times_for_position_0 = Enumerator.new do |yielder|
      last_zero = @number_of_positions - @starting_position
      number = 0
      loop do
        number += 1
        if number == 1
          yielder.yield last_zero
        else
          last_zero = last_zero + @number_of_positions
          yielder.yield last_zero
        end
      end
    end
  end

  def if_capsule_arrives_at(tick)
    disk_result = Hash.new

    (1..tick).each { |t| @positions = @positions.rotate }

    p "@time #{tick} positions are #{@positions}"
    if @positions[0] == 0 then
      disk_result[:falls_through] = tick
    else
      disk_result[:bounced_away_at] = tick
    end

    disk_result
  end

  def clone
    Disk.new(@number_of_positions, @starting_position)
  end
end