class Array
  def wall_or_space(favourite_number)
    x = self[0]
    y = self[1]
    sum = x*x + 3*x + 2*x*y + y + y*y + favourite_number
    binary = to_binary(sum)
    binary.count {|x| x==1} % 2 == 0 ? :space : :wall
  end

  private 

  def to_binary(n)
    return "0" if n == 0

    r = []

    32.times do
      if (n & (1 << 31)) != 0
        r << 1
      else
        (r << 0) if r.size > 0
      end
      n <<= 1
    end

    r
  end
end

class Node
  class << self; attr_accessor :traversed_nodes end
  class << self; attr_accessor :favourite_number end
  @traversed_nodes=[]
  @favourite_number = 0

  attr_reader :children
  attr_reader :step
  attr_reader :coord

  def initialize(coord, step)
    @coord = coord
    @step = step
    @children = []
    Node.traversed_nodes.push(coord)
  end

  def expand()
    x,y = @coord
    [ 
      [x+1, y], [x-1, y], 
      [x, y+1], [x, y-1]
    ].reject { |coord| coord[0] < 0 }
     .reject { |coord| coord[1] < 0 }
     .reject { |coord| coord.wall_or_space(Node.favourite_number) == :wall }
     .reject { |coord| Node.traversed_nodes.include? coord }
     .each do |e| 
        Node.traversed_nodes.push(e)
        @children.push(Node.new(e, step + 1))
     end
  end

  def self.next_step(nodes_at_step)
    nodes_at_step = [nodes_at_step].flatten
    nodes_at_step.each(&:expand)
    nodes_at_step.map { |e| e.children }.flatten
  end

  def self.steps_between(start, target)
    Node.traversed_nodes = []
    root = Node.new(start, 0) 
    children = Node.next_step(root)
    while !Node.traversed_nodes.include? target
      children = Node.next_step(children)
    end

    target_node = children.select { |tn| tn.coord == target }[0]
  end

  def self.nodes_within(start, total_steps)
    return total_steps if total_steps <= 1 

    Node.traversed_nodes = []
    root = Node.new(start, 0) 
    children = Node.next_step(root)

    while children.length > 0 && children[0].step < total_steps
      children = Node.next_step(children)
    end

    Node.traversed_nodes.uniq.count
  end
end





