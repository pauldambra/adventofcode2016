require_relative('../room_number.rb')

# --- Day 4: Security Through Obscurity ---

# --- Part Two ---

# With all the decoy data out of the way, it's time to decrypt this list and get moving.

# The room names are encrypted by a state-of-the-art shift cipher, which is nearly unbreakable without the right software. However, the information kiosk designers at Easter Bunny HQ were not expecting to deal with a master cryptographer like yourself.

# To decrypt a room name, rotate each letter forward through the alphabet a number of times equal to the room's sector ID. A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.

# For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.

# What is the sector ID of the room where North Pole objects are stored?

describe "day 4 - part one - security through obscurity" do
  it "can sum their sector ids" do
    room_number = RoomNumber.new
    decrypted_room_name = room_number.decrypt_room_name 'qzmt-zixmtkozy-ivhz-343'
    expect(decrypted_room_name[:room_name]).to eq('very encrypted name')
  end

  it "can solve the puzzle" do
    room_number = RoomNumber.new

    r = File.readlines(__dir__ + '/puzzle_input.txt')
            .map { |e| room_number.decrypt_room_name e }
            .select { |e| e[:room_name] == 'northpole object storage' }

    p "sector id of room that stores north pole objects is #{r}"
  end
end