

# --- Day 9: Explosives in Cyberspace ---

# Wandering around a secure area, you come across a datalink port to a new part of the network.
# After briefly scanning it for interesting files, you find one file in particular that catches
# your attention. It's compressed with an experimental format, but fortunately, the documentation
# for the format is nearby.

# The format compresses a sequence of characters. Whitespace is ignored. To indicate that some
# sequence should be repeated, a marker is added to the file, like (10x2).
# To decompress this marker, take the subsequent 10 characters and repeat them 2 times.
# Then, continue reading the file after the repeated data. The marker itself is not included
# in the decompressed output.

# If parentheses or other characters appear within the data referenced by a marker,
# that's okay - treat it like normal data, not a marker, and then resume looking
# for markers after the decompressed section.

# For example:

# * ADVENT contains no markers and decompresses to itself with no changes,
#     resulting in a decompressed length of 6.
# * A(1x5)BC repeats only the B a total of 5 times, becoming ABBBBBC for a decompressed length of 7.
# * (3x3)XYZ becomes XYZXYZXYZ for a decompressed length of 9.
# * A(2x2)BCD(2x2)EFG doubles the BC and EF, becoming ABCBCDEFEFG for a decompressed length of 11.
# * (6x1)(1x3)A simply becomes (1x3)A - the (1x3) looks like a marker,
#      but because it's within a data section of another marker,
#      it is not treated any differently from the A that comes after it.
#      It has a decompressed length of 6.
# * X(8x2)(3x3)ABCY becomes X(3x3)ABC(3x3)ABCY (for a decompressed length of 18),
#       because the decompressed data from the (8x2) marker (the (3x3)ABC) is skipped
#       and not processed further.
#
#
# What is the decompressed length of the file (your puzzle input)? Don't count whitespace.

class String
  def decompress
    input = self
    output = self

    while (match_data = /\((\d+)x(\d+)\)/.match input) do
      p "match_data #{match_data}"

      repeat_start_index = match_data.offset(0)[1]
      number_of_chars_to_repeat, repetition = match_data.captures
      sequence_to_repeat = input.slice(repeat_start_index, number_of_chars_to_repeat.to_i)
      repeated_sequence = sequence_to_repeat * repetition.to_i
      p "repeated_sequence #{repeated_sequence}"
      head = input.slice 0, match_data.begin(0)
      tail = input.slice(match_data.end(0) + sequence_to_repeat.length, input.length)
      input = "#{head}#{repeated_sequence}#{tail}"
      p input
    end

    output
  end
end

describe "day 9 part one" do
  it "can decompress ADVENT" do
    expect("ADVENT".decompress).to eq "ADVENT"
    expect("ADVENT".decompress.length).to eq 6
  end

  it "can decompress A(1x5)BC" do
    expect("A(1x5)BC".decompress).to eq "ABBBBBC"
    expect("A(1x5)BC".decompress.length).to eq 7
  end

  it "can decompress (3x3)XYZ" do
    expect("(3x3)XYZ".decompress).to eq "XYZXYZXYZ"
    expect("(3x3)XYZ".decompress.length).to eq 9
  end

  it "can decompress A(2x2)BCD(2x2)EFG" do
    expect("A(2x2)BCD(2x2)EFG".decompress).to eq "ABCBCDEFEFG"
    expect("A(2x2)BCD(2x2)EFG".decompress.length).to eq 11
  end
end








