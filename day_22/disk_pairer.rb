class DiskPair
  attr_reader :left
  attr_reader :right

  def initialize(l,r)
    a = l.position[0]+l.position[1]
    b = r.position[0]+r.position[1]
    left_is_lower = a < b
    @left = left_is_lower ? l : r
    @right = left_is_lower ? r : l

    if !@left.has_space_for(@right) &&
      !@right.has_space_for(@left)
      raise "how did we get here"
    end
  end

  def ==(other)
    other.left == @left &&
    other.right == @right
  end

  def eql?(other)
    self == other
  end

  def hash
    [@left.name, @right.name].hash
  end
end

class DiskPairer
  attr_reader :pairs
  def initialize(disks)
    @disks = disks
    @pairs = Set.new

    @disks.each do |node_a|
      next if node_a.is_empty?
      @disks.each do |node_b|
        next if node_a == node_b
        next if !node_b.has_space_for(node_a)
        @pairs.add(DiskPair.new(node_a,node_b))
      end
    end
  end
end