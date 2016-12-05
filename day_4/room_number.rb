
# Each room consists of 
# * an encrypted name (lowercase letters separated by dashes) followed by a dash, 
# * a sector ID, 
# * and a checksum in square brackets.

# A room is real (not a decoy) if the checksum is the five most common letters 
# in the encrypted name, in order, with ties broken by alphabetization. For example:
class RoomNumber
  attr_reader :sector_ids

  def initialize
    @sector_ids = 0
  end

  def add_sector_id_if_real!(encrypted_room_number)
    parts = separate_parts_from encrypted_room_number
    if generated_checksum(parts) == parts[:checksum] then
      @sector_ids += parts[:sector_id]
    end
  end

  # To decrypt a room name, rotate each letter forward through the alphabet 
  # a number of times equal to the room's sector ID. 
  # A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.
  def decrypt_room_name(encrypted_room_name)
    x = separate_parts_from encrypted_room_name
    rotations = get_rotations(x[:sector_id])

    decrypted_name = x[:encrypted_room_name]
                      .chars
                      .map { |c| c == '-' ? ' ' : rotations[c] }
                      .join('')

    {
      room_name: decrypted_name,
      sector_id: x[:sector_id]
    }
  end

  private

  def separate_parts_from(encrypted_room_number)
    x = encrypted_room_number.split('[')
    y = x[0].split_by_last '-'

    {
      checksum: (x[1] || '').chomp().chomp(']'),
      sector_id: y[1].to_i,
      encrypted_room_name: y[0]
    }
  end

  def generated_checksum(parts)
    parts[:encrypted_room_name]
      .count_each_character      
      .group_by { |k, v| v }
      .map { |k, v| [k, v.map { |e| e[0] }] }
      .sort_by { |e| e[0] }
      .reverse
      .flat_map { |e| e[1] }
      .take(5)
      .join('')
  end

  def get_rotations(shift)
    alphabet = ('a'..'z').to_a
    Hash[alphabet.zip(alphabet.rotate(shift))]
  end
end

class String
  def split_by_last(char=" ")
    pos = self.rindex(char)
    pos != nil ? [self[0...pos], self[pos+1..-1]] : [self]
  end

  def count_each_character
    self.split('-')
        .join('')
        .chars
        .map(&:downcase)
        .sort
        .join
        .chars
        .group_by { |i| i }
        .map { |k, v| [k, v.length] }
  end
end