class SwapCharacterByIndex
  def self.scramble(s, instruction)
    swapper = /swap position (\d+) with position (\d+)/.match instruction
    if swapper
      l = swapper.captures[0].to_i
      r = swapper.captures[1].to_i
      a = s[l]
      b = s[r]
      x = s.chars
      x[r] = a
      x[l] = b
      x.join('')
    else
      s
    end
  end

  def self.unscramble(s, instruction)
    self.scramble(s, instruction)
  end
end