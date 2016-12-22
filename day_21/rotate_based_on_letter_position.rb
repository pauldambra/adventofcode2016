class RotateBasedOnLetterPosition
  def self.scramble(s, instruction)
    swapper = /rotate based on position of letter (\p{L})/.match instruction
    if swapper
      x = swapper.captures[0]
      s = s.chars
      y = s.index(x)
      y = y + 1
      y = y + 1 if y > 4
      y = y * -1
      s.rotate(y).join('')
    else
      s
    end
  end

#abdec => ecabd
# b was at 2 so rotate right 3

#ecabd => abdec
# b now at 4.
# rotate left 

  def self.unscramble(s, instruction)
    # return if s.length == 5
    # swapper = /rotate based on position of letter (\p{L})/.match instruction
    # if swapper
    #   x = swapper.captures[0]
    #   # orig = {
    #   #   0: 7
    #   #   1: 0,
    #   #   2: 4,
    #   #   3: 1,
    #   #   4: 5,
    #   #   5: 2,
    #   #   6: 6,
    #   #   7: 3
    #   # }
    #   orig_mapping = [7,0,4,1,5,2,6,3]
    #   s = s.chars
    #   pos = s.index(x)
    #   orig_pos = orig_mapping[pos]

    #   p "#{x} is at #{pos} in #{s} so started at #{orig_pos}"
    #   loop do
    #     s = s.rotate
    #     break if s.index(x) == orig_pos
    #   end
    # else
      s
    # end
  end
end