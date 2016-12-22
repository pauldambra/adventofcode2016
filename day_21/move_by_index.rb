class MovePositionByIndex
  def self.scramble(s, instruction)
    swapper = /move position (\d+) to position (\d+)/.match instruction
    if swapper
      x = swapper.captures[0].to_i
      y = swapper.captures[1].to_i

      s = s.chars
      m = s.slice!(x)
      s.insert(y, m).join('')
    else
      s
    end
  end

  def self.unscramble(s, instruction)
    swapper = /move position (\d+) to position (\d+)/.match instruction
    if swapper
      x = swapper.captures[0].to_i
      y = swapper.captures[1].to_i

      s = s.chars
      m = s.slice!(y)
      s.insert(x, m).join('')
    else
      s
    end
  end
end