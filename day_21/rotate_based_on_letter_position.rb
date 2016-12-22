class RotateBasedOnLetterPosition
  class << self
    attr_reader :five_char_index_map
    attr_reader :eight_char_index_map
  end

  def self.scramble(s, instruction)
    swapper = /rotate based on position of letter (\p{L})/.match instruction
    if swapper
      x = swapper.captures[0]
      s = s.chars
      y = s.index(x)
      nr = scramble_index(y)
      s.rotate(nr).join('')
    else
      s
    end
  end

  def self.scramble_index(i)
    (1 + (i >= 4 ? 1 : 0) + i) * -1
  end

# make arrays where the index in the array is the scrambled index of a letter
# and it's value is that original index for that scrambled index
  def self.build_index_map 
    @five_char_index_map = (0..4).map { |i| 
      nr = scramble_index(i)
      a = "01234".chars.rotate(nr)
      final_index = a.index(i.to_s)
      mapping = [final_index, i]
    }.sort {|a, b| a[0] <=> b[0] }
     .map { |e| e[1] }

    @eight_char_index_map = (0..7).map { |i| 
      nr = scramble_index(i)
      a = "01234567".chars.rotate(nr)
      final_index = a.index(i.to_s)
      [final_index, i]
    }.sort {|a, b| a[0] <=> b[0] }
     .map { |e| e[1] }
  end
  self.build_index_map

  def self.unscramble(s, instruction)
    
    swapper = /rotate based on position of letter (\p{L})/.match instruction
    if swapper
      x = swapper.captures[0]
    
      s = s.chars
      pos = s.index(x)
      if s.length==5
        orig_pos = @five_char_index_map[pos]
      else
        orig_pos = @eight_char_index_map[pos]
      end
      loop do
        s = s.rotate
        break if s.index(x) == orig_pos
      end
      s.join('')
    else
      s
    end
  end
end