
require_relative('../error_correcting_reader.rb')
# --- Day 6: Signals and Noise ---

# Something is jamming your communications with Santa. Fortunately,
# your signal is only partially jammed, and protocol in situations like this
# is to switch to a simple repetition code to get the message through.

# In this model, the same message is sent repeatedly.
# You've recorded the repeating message signal (your puzzle input),
# but the data seems quite corrupted - almost too badly to recover. Almost.

# All you need to do is figure out which character is most frequent for each position.
# For example, suppose you had recorded the following messages:

example_input = %{
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar
}

# The most common character in the first column is e; in the second,
# a; in the third, s, and so on. Combining these characters returns the
# error-corrected message, easter.

# Given the recording in your puzzle input, what is the error-corrected
# version of the message being sent?

describe "day 6 part one" do
  it "can decode the example message" do
    decoded_word = ErrorCorrectingReader.read(example_input.lines)
    expect(decoded_word).to eq('easter')
  end

  it "can solve the puzzle input" do
    decoded_word = ErrorCorrectingReader.read(File.readlines(__dir__ + '/puzzle_input.txt'))
    p "decoded puzzle input as #{decoded_word}"
  end
end
