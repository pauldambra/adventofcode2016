class String
  def scramble(instruction)
    s = SwapCharacterByIndex.scramble(self, instruction)
    s = SwapCharacterByLetter.scramble(s, instruction)
    s = ReverseSequence.scramble(s, instruction)
    s = RotateBySteps.scramble(s, instruction)
    s = MovePositionByIndex.scramble(s, instruction)
    s = RotateBasedOnLetterPosition.scramble(s, instruction)
  end

  def follow_scramble_instructions(instructions)
    s = self
    instructions.each_with_index do |ins, i| 
      p "#{i}: #{ins}"
      s = s.scramble(ins) 
      p s
    end
    s
  end
end