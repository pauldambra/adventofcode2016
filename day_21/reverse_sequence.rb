class ReverseSequence
  def self.scramble(s, instruction)
    swapper = /reverse positions (\d+) through (\d+)/.match instruction
    if swapper
      
      x = swapper.captures[0].to_i
      y = swapper.captures[1].to_i

      z = s.chars

      l = z[0,x-0]
      m = z[x,y-x+1].reverse
      r = s.slice(y+1..-1)

      [l, m, r].join('')
    else
      s
    end
  end

  def self.unscramble(s, instruction)
    self.scramble(s, instruction)
  end
end