require_relative('../string_decompress.rb')

# --- Part Two ---

# Apparently, the file actually uses version two of the format.

# In version two, the only difference is that markers within decompressed data are decompressed. This, the documentation explains, provides much more substantial compression capabilities, allowing many-gigabyte files to be stored in only a few kilobytes.

# For example:

# (3x3)XYZ still becomes XYZXYZXYZ, 
    # as the decompressed section contains no markers.
# X(8x2)(3x3)ABCY becomes XABCABCABCABCABCABCY, because the decompressed data from the (8x2) marker is then further decompressed, thus triggering the (3x3) marker twice for a total of six ABC sequences.
# (27x12)(20x12)(13x14)(7x10)(1x12)A decompresses into a string of A repeated 241920 times.
# (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN becomes 445 characters long.
# Unfortunately, the computer you brought probably doesn't have enough memory to actually decompress the file; you'll have to come up with another way to get its decompressed length.


describe "day 9 part two" do
  it "can decompress (3x3)XYZ" do
    expect("(3x3)XYZ".decompress_v2).to eq  9 # "XYZXYZXYZ"
  end

  it "can decompress X(8x2)(3x3)ABCY" do
    expect("X(8x2)(3x3)ABCY".decompress_v2).to eq 20 # "XABCABCABCABCABCABCY"
  end

  it "can decompress (27x12)(20x12)(13x14)(7x10)(1x12)A" do
    expect("(27x12)(20x12)(13x14)(7x10)(1x12)A".decompress_v2).to eq 241920
  end
  
  it "can decompress (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"  do
    expect("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN".decompress_v2).to eq 445
  end

  it "can decompres the puzzle input" do
    input = File.read(__dir__ + '/puzzle_input.txt').gsub(/\s+/, "")
    decompressed_length = input.decompress_v2
    puts "decompressed length = #{decompressed_length}"
  end
end