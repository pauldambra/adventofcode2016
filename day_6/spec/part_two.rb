# --- Part Two ---

# Of course, that would be the message - if you hadn't agreed to use a modified repetition code instead.

# In this modified code, the sender instead transmits what looks like random data, but for each character, the character they actually want to send is slightly less likely than the others. Even after signal-jamming noise, you can look at the letter distributions in each column and choose the least common letter to reconstruct the original message.

# In the above example, the least common character in the first column is a; in the second, d, and so on. Repeating this process for the remaining characters produces the original message, advent.

# Given the recording in your puzzle input and this new decoding methodology, what is the original message that Santa is trying to send?

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

describe "day 6 part two" do
  it "can decode the example message" do
    decoded_word = ErrorCorrectingReader.read_least_common(example_input.lines)
    expect(decoded_word).to eq('advent')
  end

  it "can solve the puzzle input" do
    decoded_word = ErrorCorrectingReader.read_least_common(File.readlines(__dir__ + '/puzzle_input.txt'))
    p "decoded puzzle input as #{decoded_word}"
  end
end