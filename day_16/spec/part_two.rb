require_relative('../dragon_checksum.rb')

# --- Part Two ---

# The second disk you have to fill has length 35651584. Again using the initial
# state in your puzzle input, what is the correct checksum for this disk?

describe "day 16 part two" do
  it "can calculate the ginormous checksum" do
    checksum = "01110110101001000".dragon_checksum_for_length(35651584)
    p "puzzle checksum is #{checksum}"
  end
end