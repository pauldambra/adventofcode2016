class RotateBySteps
  def self.scramble(s, instruction)
    swapper = /rotate (left|right) (\d+) step/.match instruction
    if swapper
      dir = swapper.captures[0]
      x = swapper.captures[1].to_i
      x = x * -1 if dir == 'right'
      s.chars.rotate(x).join('')
    else
      s
    end
  end

  def self.unscramble(s, instruction)
    swapper = /rotate (left|right) (\d+) step/.match instruction
    if swapper
      dir = swapper.captures[0]
      x = swapper.captures[1].to_i
      x = x * -1 if dir == 'left'
      s.chars.rotate(x).join('')
    else
      s
    end
  end
end