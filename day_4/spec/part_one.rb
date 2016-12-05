require_relative('../room_number.rb')

# --- Day 4: Security Through Obscurity ---

# Finally, you come across an information kiosk with a list of rooms. Of course, the list is encrypted and full of decoy data, but the instructions to decode the list are barely hidden nearby. Better remove the decoy data first.

# Each room consists of an encrypted name (lowercase letters separated by dashes) followed by a dash, a sector ID, and a checksum in square brackets.

# A room is real (not a decoy) if the checksum is the five most common letters in the encrypted name, in order, with ties broken by alphabetization. For example:

# aaaaa-bbb-z-y-x-123[abxyz] is a real room because the most common letters are a (5), b (3), and then a tie between x, y, and z, which are listed alphabetically.
# a-b-c-d-e-f-g-h-987[abcde] is a real room because although the letters are all tied (1 of each), the first five are listed alphabetically.
# not-a-real-room-404[oarel] is a real room.
# totally-real-room-200[decoy] is not.
# Of the real rooms from the list above, the sum of their sector IDs is 1514.

# What is the sum of the sector IDs of the real rooms?

describe "day 4 - part one - security through obscurity" do
  it "can sum their sector ids" do
    room_number = RoomNumber.new
    room_number.add_sector_id_if_real! 'aaaaa-bbb-z-y-x-123[abxyz]'
    room_number.add_sector_id_if_real! 'a-b-c-d-e-f-g-h-987[abcde]'
    room_number.add_sector_id_if_real! 'not-a-real-room-404[oarel]'
    room_number.add_sector_id_if_real! 'totally-real-room-200[decoy]'

    expect(room_number.sector_ids).to eq(1514)
  end

  it "can solve the puzzle" do
    room_number = RoomNumber.new

    File.readlines(__dir__ + '/puzzle_input.txt')
      .each { |e| room_number.add_sector_id_if_real! e }

    p "sum of real sector ids is #{room_number.sector_ids}"
  end
end