class SwapCharacterByLetter
  def self.scramble(s, instruction)
    swapper = /swap letter (\p{L}) with letter (\p{L})/.match instruction
    if swapper
      l = swapper.captures[0]
      r = swapper.captures[1]
      a = s.index(l)
      b = s.index(r)
      x = s.chars

      x[a] = r
      x[b] = l
      x.join('')
    else
      s
    end
  end

  def self.unscramble(s, instruction)
    self.scramble(s, instruction)
  end
end