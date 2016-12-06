require_relative('../../common/array.rb')

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
    columns = example_input
      .lines
      .chunk_columns_of_characters_by(6, example_input.lines.count - 1)
    expect(columns.length).to be(6)

    most_freq_by_col = columns.map { |c| c.group_by(&:chr).map { |k, v| [k, v.size] } }
      .map do |c|
        c.sort_by { |k,v| v }
         .reverse
         .take(1)
      end

    decoded_word = most_freq_by_col.map { |c| c[0][0] }.join('')

    expect(decoded_word).to eq('easter')
  end
end
