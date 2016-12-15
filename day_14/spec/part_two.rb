require_relative('../pad_generator.rb')
require_relative('../hasheriser.rb')

# --- Part Two ---

# Of course, in order to make this process even more secure,
# you've also implemented key stretching.

# Key stretching forces attackers to spend more time generating
# hashes. Unfortunately, it forces everyone else to spend more
# time, too.

# To implement key stretching, whenever you generate a hash,
# before you use it, you first find the MD5 hash of that hash,
# then the MD5 hash of that hash, and so on, a total of 2016
# additional hashings. Always use lowercase hexadecimal
# representations of hashes.

# For example, to find the stretched hash for index 0 and salt abc:

# Find the MD5 hash of abc0: 
#      577571be4de9dcce85a041ba0410f29f.
# Then, find the MD5 hash of that hash: 
#      eec80a0c92dc8a0777c619d9bb51e910.
# Then, find the MD5 hash of that hash:
#      16062ce768787384c81fe17a7a60c7e3.
# ...repeat many times...
# Then, find the MD5 hash of that hash:
#      a107ff634856bb300138cac6568c0f24.
# So, the stretched hash for index 0 in this situation is a107ff....
# In the end, you find the original hash (one use of MD5),
# then find the hash-of-the-previous-hash 2016 times,
# for a total of 2017 uses of MD5.

# The rest of the process remains the same, but now the keys are
# entirely different. Again for salt abc:

# The first triple (222, at index 5) has no matching 22222 in the
# next thousand hashes.
# The second triple (eee, at index 10) hash a matching eeeee
# at index 89, and so it is the first key.
# Eventually, index 22551 produces the 64th key (triple fff with
# matching fffff at index 22859.
# Given the actual salt in your puzzle input and using 2016
# extra MD5 calls of key stretching, what index now produces
# your 64th one-time pad key?

# Your puzzle input is still ihaygndm.

describe "day 14 part two" do
  it "can get the stretched key for abc0" do
    r = StretchingHasheriser.new.make('abc', 0)
    expect(r).to eq 'a107ff634856bb300138cac6568c0f24'
  end

  it "can solve example input" do
    salt = 'abc'
    generator = PadGenerator.new(salt, StretchingHasheriser.new)
    generated_keys = generator.GetSixtyFourKeys

    expect(generated_keys.last[:index]).to eq 22551
  end

  it "can solve puzzle input" do
    salt = 'ihaygndm'
    generator = PadGenerator.new(salt, StretchingHasheriser.new)
    generated_keys = generator.GetSixtyFourKeys

    p generated_keys.last
  end
end