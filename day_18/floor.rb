class Floor
  def initialize(r1)
    @rows = [r1]
  end

  def generate_next_n_rows(n)
    (1..n).each do |i|
      prev_row = @rows[i - 1]
      new_row = ".#{prev_row}."
                  .chars
                  .each_cons(3) 
                  .map { |e| tile_from(e) }
      @rows.push(new_row.join(''))
    end
    @rows
  end

# Its left and center tiles are traps, but its right tile is not.
# Its center and right tiles are traps, but its left tile is not.
# Only its left tile is a trap.
# Only its right tile is a trap.
# In any other situation, the new tile is safe.
  def tile_from(tiles)
    tiles[0] != tiles[2] ? '^' : '.'
  end

  def self.safe_tile_count(rows)
    rows.join('').count('.')
  end
end