class DiskNode
  attr_reader :name
  attr_reader :position
  attr_reader :used
  attr_reader :available

  def initialize(df)
    x = /\/dev\/grid\/(node-x(\d+)-y(\d+))\s+\d+T\s+(\d+)T\s+(\d+)T/.match(df)
    @name = x.captures[0]
    @position = [
      x.captures[1].to_i,
      x.captures[2].to_i
    ]
    @used = x.captures[3].to_i
    @available = x.captures[4].to_i
  end

  def has_space_for(other)
    @available > other.used
  end

  def is_empty?
    @used == 0
  end

  def is_not_empty?
    !is_empty?
  end

  def ==(other)
    @name == other.name
  end

  def eql?(other)
    self == other
  end

  def hash
    @name.hash
  end
end