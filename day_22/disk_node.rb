class NotEnoughSpace < StandardError; end

class DiskNode
  attr_reader :name
  attr_reader :position
  attr_accessor :used
  attr_accessor :available

  def initialize(name, position, used, available)
    @name = name
    @position = position
    @used = used
    @available = available
  end

  def self.parse(df)
    x = /\/dev\/grid\/(node-x(\d+)-y(\d+))\s+\d+T\s+(\d+)T\s+(\d+)T/.match(df)
    name = x.captures[0]
    position = [
      x.captures[1].to_i,
      x.captures[2].to_i
    ]
    used = x.captures[3].to_i
    available = x.captures[4].to_i
    DiskNode.new(name, position, used, available)
  end

  def has_space_for(other)
    @available >= other.used
  end

  def is_empty?
    @used == 0
  end

  def is_not_empty?
    !is_empty?
  end

  def take_data_from(other)
    if other.used > @available
      raise NotEnoughSpace, "cannot fit #{other.used} into available space #{@available}"
    end

    @used = @used + other.used
    @available = @available - other.used
    other.available = other.available + other.used
    other.used = 0
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

  def self.parse_many(arr)
    arr.select { |e| e.start_with? '/dev/grid' }
     .map(&:chomp)
     .map { |e| DiskNode.parse e }
  end

  def clone
    DiskNode.new(@name.clone, @position.clone, @used, @available)
  end
end