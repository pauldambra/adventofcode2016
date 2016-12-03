class CompassPoint
end

class North < CompassPoint
  def left
    West.new
  end

  def right
    East.new
  end

  def walk(coords)
    [coords[0], coords[1]+1]
  end
end

class East < CompassPoint
  def left
    North.new
  end

  def right
    South.new
  end

  def walk(coords)
    [coords[0]+1, coords[1]]
  end
end

class South < CompassPoint
  def left
    East.new
  end

  def right
    West.new
  end

  def walk(coords)
    [coords[0], coords[1]-1]
  end
end

class West < CompassPoint
  def left
    South.new
  end

  def right
    North.new
  end 

  def walk(coords)
    [coords[0]-1, coords[1]]
  end
end