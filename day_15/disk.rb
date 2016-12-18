
class Disk
  @button_multiple ||= 1
  def self.set_button_multiple_for(disks)
    multiple = disks.select { |d| d.positions[0] == 0 }
                    .map { |d| d.positions.length }
                    .reduce(:lcm)
    @button_multiple = multiple
  end

  def self.button_multiple
    @button_multiple
  end

  attr_reader :times_for_button_press
  attr_reader :positions

  def initialize(index_in_sculpture, number_of_positions, starting_position)
    @number_of_positions = number_of_positions
    @positions = *(0..number_of_positions - 1)
    @starting_position = starting_position
    @positions = @positions.rotate(starting_position)

    # a disk is at a position in a sculpture.
    # for each time at which it would be at position 0
    # the equivalent button press time is 
    # its position in that time less its position in 
    # the sculpture
    @times_for_button_press = Enumerator.new do |yielder|
      last_zero = @number_of_positions - @starting_position
      number = 0
      loop do
        number += 1
        if number == 1
          yielder.yield last_zero - (index_in_sculpture + 1)
        else
          last_zero = last_zero + @number_of_positions
          yielder.yield get_button_press(last_zero, index_in_sculpture)
        end
      end
    end
  end

  def get_button_press(zero_pos, i)
    zero_pos - (i + 1)
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

  def to_a
    Disk.new(@number_of_positions, @starting_position).positions
  end
end