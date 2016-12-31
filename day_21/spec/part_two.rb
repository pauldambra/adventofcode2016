require_relative('../swap_character_by_index.rb')
require_relative('../swap_character_by_letter.rb')
require_relative('../reverse_sequence.rb')
require_relative('../rotate_by_steps.rb')
require_relative('../move_by_index.rb')
require_relative('../rotate_based_on_letter_position.rb')
require_relative('../string.rb')

# --- Part Two ---

# You scrambled the password correctly, but you discover that you can't
# actually modify the password file on the system. You'll need to
# un-scramble one of the existing passwords by reversing the scrambling
# process.

# What is the un-scrambled version of the scrambled password fbgdceah?

class String
  def unscramble(instruction)
    s = SwapCharacterByIndex.unscramble(self, instruction)
    s = SwapCharacterByLetter.unscramble(s, instruction)
    s = ReverseSequence.unscramble(s, instruction)
    s = RotateBySteps.unscramble(s, instruction)
    s = MovePositionByIndex.unscramble(s, instruction)
    s = RotateBasedOnLetterPosition.unscramble(s, instruction)
  end

  def follow_unscramble_instructions(instructions)
    s = self
    instructions.reverse.each_with_index do |ins, i| 
      s = s.unscramble(ins) 
    end
    s
  end
end

describe "day 21 - part 2" do
  it "can swap positions by index" do
    unscrambled = "ebcda".unscramble('swap position 4 with position 0')
    expect(unscrambled).to eq "abcde"
  end

  it "can swap positions by letter" do
    unscrambled = "edcba".unscramble('swap letter d with letter b')
    expect(unscrambled).to eq "ebcda"
  end

  it "can reverse sequence within string" do
    unscrambled = "abcde".unscramble('reverse positions 0 through 4')
    expect(unscrambled).to eq "edcba"
  end

  it "can rotate right" do
    unscrambled = "cdeab".unscramble('rotate right 3 steps')
    expect(unscrambled).to eq "abcde"
  end

  it "can rotate left" do
    unscrambled = "bcdea".unscramble('rotate left 1 step')
    expect(unscrambled).to eq "abcde"
  end

  it "can move letter by index" do
    unscrambled = "bdeac".unscramble('move position 1 to position 4')
    expect(unscrambled).to eq "bcdea"

    unscrambled = "abdec".unscramble('move position 3 to position 0')
    expect(unscrambled).to eq "bdeac"
  end

    # can solve this. it is not invertible. d at index 0 could have come
    # from index 2 or 4
  # it "can rotate by index" do
    # unscrambled = "ecabd".unscramble('rotate based on position of letter b')
    # expect(unscrambled).to eq 'abdec'

    # unscrambled = "decab".unscramble('rotate based on position of letter d')
    # expect(unscrambled).to eq 'ecabd'
  # end

  it "can unrotate 8 letter strings" do

    letters = "abcdefgh".chars

    letters.each do |l|
      x = "abcdefgh".scramble("rotate based on position of letter #{l}")
      indx = x.index(l)
      y = x.unscramble("rotate based on position of letter #{l}")
      expect(y).to eq "abcdefgh"
    end
  end

  # can solve this. it is not invertible. d at index 0 could have come
  # from index 2 or 4
  # it "can follow a sequence of instructions" do
  #   unscrambled = "decab".follow_unscramble_instructions([
  #     'swap position 4 with position 0',
  #     'swap letter d with letter b',
  #     'reverse positions 0 through 4',
  #     'rotate left 1 step',
  #     'move position 1 to position 4',
  #     'move position 3 to position 0',
  #     'rotate based on position of letter b',
  #     'rotate based on position of letter d'
  #     ])
  #   expect(unscrambled).to eq 'abcde'
  # end

  it "can solve the puzzle input" do
    instructions = File.readlines(__dir__ + '/puzzle_input.txt')
                      .map(&:chomp)

    unscrambled = "fbgdceah".follow_unscramble_instructions(instructions)
    p "scrambled pass = #{unscrambled}"
  end
end









