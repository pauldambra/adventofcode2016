class Hmmm
  def expand_length(s)
    to_first_marker = s.index('(')

    if (to_first_marker == nil)
      return s.length
    else
      pass_along = s.slice(to_first_marker, s.length)
      return to_first_marker + expand_marker(pass_along)
    end
  end

  def expand_marker(s)
    next_marker_end = s.index(')')
    marker = s.slice(0, next_marker_end + 1)

    char_count, reps = marker.split('x')
    char_count = char_count.slice(1, char_count.length).to_i
    reps = reps.slice(0, reps.length - 1).to_i

    pass_along = s.slice(next_marker_end + 1, char_count)

    repeated_string_length = expand_length(pass_along) * reps

    end_of_this_section = next_marker_end + 1 + char_count

    repeated_string_length + expand_length(s.slice(end_of_this_section, s.length))
  end
end

class SeekingMarker
  def next(c, output)
    if c != '('
      # p "adding #{c} to output"
      output.push c
      return self
    else
      # p "starting marker"
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
      # p "read #{c} into MarkerCharacterCountReader"
      return self
    else
      # p "now reading number of repeats"
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
      # p "read #{c} into MarkerRepetitionReader"
      return self
    else
      reps = @repetition.join('').to_i
      # p "ready to find repeating section"
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
      # p "reading #{c} into #{@capture} with #{@num_to_capture} still to read"
      @capture.push(c)
      @num_to_capture -= 1
      # p "and now #{@num_to_capture} still to read"
    end

    if @num_to_capture == 0
      # p "completing capture of #{@capture}"
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
      # p "processing #{c}"
      state = state.next c, output      
    end

    output.join('')
  end

  def decompress_v2
    # candidate_output = self

    # while /\(\d+x\d+\)/ =~ candidate_output
    #   output = []
    #   state = SeekingMarker.new

    #   for c in candidate_output.chars  
    #     # p "processing #{c}"
    #     state = state.next c, output      
    #   end

    #   candidate_output = output.join('')
    # end

    # candidate_output

    return Hmmm.new.expand_length(self)
  end
end





