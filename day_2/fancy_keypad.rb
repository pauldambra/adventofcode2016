
class FancyKeypad
  attr_reader :code_entered

  def initialize(keypad, starting_coordinates)
    @code_entered = []
    @keypad = keypad
    @current_key = starting_coordinates
  end

  def clamp(n)
    n = [0, n].max
    n = [n, @keypad[0].length-1].min
  end

  def clamped_value(x, y)
    x = clamp(x)
    y = clamp(y)
    {x: x, y: y}
  end

  def move_finger(direction)
    case direction
    when 'U'
      candidate_key = clamped_value(@current_key[:x], @current_key[:y] - 1)
    when 'R'
      candidate_key = clamped_value(@current_key[:x] + 1, @current_key[:y])
    when 'D'
      candidate_key = clamped_value(@current_key[:x], @current_key[:y] + 1)
    when 'L'
      candidate_key = clamped_value(@current_key[:x] - 1, @current_key[:y])
    end

    @current_key = candidate_key unless key_at(candidate_key) == nil
  end

  def key_at(coord)
    # reverse the coordinates here because of how the keypad array is built
    @keypad[coord[:y]][coord[:x]]
  end

  def key_under_finger
    key_at(@current_key)
  end

  def push_button
    k = key_under_finger
    p "pushing #{k}"
    @code_entered.push(k)
  end

  def enter(instructions)
    instructions.split('').each {|i| move_finger(i) }
    push_button
  end
end