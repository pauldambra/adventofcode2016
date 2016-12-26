
class Coordinate
  def self.neighbours(coord, max_x, max_y)
    x = coord[0]
    y = coord[1]

    candidates = [
      [x-1, y],
      [x+1, y],
      [x, y-1],
      [x, y+1]
    ]

    candidates
      .reject { |c| c[0]<0 }
      .reject { |c| c[1]<0 }
      .reject { |c| c[0]>max_x }
      .reject { |c| c[1]>max_y }
  end
end