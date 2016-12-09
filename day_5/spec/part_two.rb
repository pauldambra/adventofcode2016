
# --- Part Two ---

# As the door slides open, you are presented with a second door that
# uses a slightly more inspired security mechanism. Clearly unimpressed
# by the last version (in what movie is the password decrypted in order?!), 
# the Easter Bunny engineers have worked out a better solution.

# Instead of simply filling in the password from left to right,
# the hash now also indicates the position within the password to fill.
# You still look for hashes that begin with five zeroes; however, now,
# the sixth character represents the position (0-7), and the seventh character
# is the character to put in that position.

# A hash result of 000001f means that f is the second character in the password.
# Use only the first result for each position, and ignore invalid positions.

# For example, if the Door ID is abc:

# The first interesting hash is from abc3231929, which produces 0000015...;
# so, 5 goes in position 1: _5______.
# In the previous method, 5017308 produced an interesting hash; however,
# it is ignored, because it specifies an invalid position (8).
# The second interesting hash is at index 5357525, which produces 000004e...;
# so, e goes in position 4: _5__e___.
# You almost choke on your popcorn as the final character falls into place,
# producing the password 05ace8e3.

# Given the actual Door ID and this new method, what is the password?
# Be extra proud of your solution if it uses a cinematic "decrypting" animation.

# Your puzzle input is still ojvtpuvg.

module SecondDoorHacker
  module_function

  def hack(door_id)
    password_chars = []
    index = 0
    acceptable_indexes = [0,1,2,3,4,5,6,7].map { |i| i.to_s }

    while password_chars.count { |c| !!c } < 8 do
      hash = Digest::MD5.hexdigest "#{door_id}#{index}"
      if hash.start_with?('00000') then
        candidate_index = hash[5]
        candidate_value = hash[6]

        if acceptable_indexes.include? candidate_index then
          password_chars[candidate_index.to_i] = candidate_value if password_chars[candidate_index.to_i] == nil
        end
      end
      index += 1
    end

    return password_chars.join('')
  end
end

describe "day 5 - part two - how about a nice game of chess" do
  it "can find the example password" do
    expect(SecondDoorHacker.hack 'abc').to eq('05ace8e3')
  end

  it "solve the problem" do
    p "puzzle solution is #{SecondDoorHacker.hack 'ojvtpuvg'}"
  end
end