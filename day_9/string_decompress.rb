class SeekingMarker
  def next(c, output)
    if c != '('
      p "adding #{c} to output"
      output.push c
      return self
    else
      p "starting marker"
      return MarkerCharacterCountReader.new
    end
  end
end

class MarkerCharacterCountReader
  def initialize
    @number_of_chars_to_repeat = []
  end

  def next(c, output)
    if c != 'x'
      @number_of_chars_to_repeat.push c
      p "read #{c} into MarkerCharacterCountReader"
      return self
    else
      p "now reading number of repeats"
      return MarkerRepetitionReader.new(@number_of_chars_to_repeat.join('').to_i)
    end
  end
end

class MarkerRepetitionReader
  def initialize(number_of_chars_to_repeat)
    @number_of_chars_to_repeat = number_of_chars_to_repeat
    @repetition = []
  end

  def next(c, output)
    if c != ')'
      @repetition.push c
      p "read #{c} into MarkerRepetitionReader"
      return self
    else
      reps = @repetition.join('').to_i
      p "ready to find repeating section"
      return Repeater.new(@number_of_chars_to_repeat, reps)
    end
  end
end

class Repeater
  def initialize(chars_to_capture, reps)
    @num_to_capture = chars_to_capture
    @reps = reps
    @capture = []
  end

  def next(c, output)

    if @num_to_capture >= 1
      p "reading #{c} into #{@capture} with #{@num_to_capture} still to read"
      @capture.push(c)
      @num_to_capture -= 1
      p "and now #{@num_to_capture} still to read"
    end

    if @num_to_capture == 0
      p "completing capture of #{@capture}"
      output.push @capture.join('') * @reps
      return SeekingMarker.new
    else
      return self
    end
  end
end



class String
  def decompress
    output = []

    state = SeekingMarker.new

    for c in self.chars  
      p "processing #{c}"
      state = state.next c, output      
    end

    output.join('')
  end

  def decompress_v2
    output = []

    state = SeekingMarker.new

    for c in self.chars  
      p "processing #{c}"
      state = state.next c, output      
    end

    output.join('')
  end
end





