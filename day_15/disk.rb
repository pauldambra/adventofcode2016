
class Disk
  @button_multiple

  class << self

    def set_button_multiple_for(disks)
      multiple = disks.select { |d| d.positions[0] == 0 }
                      .map { |d| d.positions.length }
                      .reduce(:lcm)
      disks.each { |d| d.button_multiple = multiple || 1 }
    end

  end

  attr_reader :times_for_button_press
  attr_reader :positions
  attr_accessor :button_multiple

  def initialize(index_in_sculpture, number_of_positions, starting_position)
    @button_multiple = @button_multiple || 1
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
      first = true
      last_zero = -1337

      loop do
        if first
          last_zero = @number_of_positions - @starting_position
          next_press_for_zero_pos = get_button_press(last_zero, index_in_sculpture)
          first = false
        else

          if @button_multiple == 1 
            last_zero = last_zero + @number_of_positions
            # p "disk multiple is 1, set last zero to #{last_zero}"
          else
            last_zero = last_zero + @button_multiple  
            # p "stepped last zero by #{@button_multiple} to #{last_zero}"
          end
          
          next_press_for_zero_pos = get_button_press(last_zero, index_in_sculpture)
          
        end

        yielder.yield next_press_for_zero_pos
      end
    end
  end

  def get_button_press(zero_pos, index_in_sculpture)
    press = zero_pos - (index_in_sculpture + 1)
    # p "pressing at time #{zero_pos} - (#{index_in_sculpture} + 1) = #{press}"
    press
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