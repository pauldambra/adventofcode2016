class DiskGrid
  attr_reader :nodes
  attr_reader :max_x
  attr_reader :max_y

  def initialize(nodes)
    @max_x = nodes.max { |a, b| a.position[0]<=>b.position[0] }.position[0]
    @max_y = nodes.max { |a, b| a.position[1]<=>b.position[1] }.position[1]

    @desired_data_node = [@max_x, 0]

    @nodes = Hash.new
    nodes.each do |node|
      @nodes[node.position] = node
    end
  end

  def step_empty_to_goal
    EmptyToGoalPathFinder.new(self).find_path
  end

  def pretty_print
    rows = []
    (0..@max_y).each do |y|
      cols = (0..@max_x).map do |x|
        node = @nodes[[x,y]]
        neighbours = get_neighbours [x,y]

        if [x,y] == [0,0]
          '(.)'
        elsif [x,y] == @desired_data_node
          ' G '
        elsif node.is_empty?
          ' _ '
        elsif neighbours.none? do |neighbour| 
          r = neighbour.has_space_for(node)
           # puts "-----\nfor node #{node.name} with #{node.used},\n neighbour #{neighbour.name} with avail #{neighbour.available}.\n has space? #{r}"
          r
        end
          ' # '
        else
          ' . '
        end
      end
      rows.push(cols)
    end
    rows.map { |r| r.join('') }
  end

  def get_neighbours(pos)
    Coordinate.neighbours(pos, @max_x, @max_y)
      .map {|c| @nodes[c] }
  end

  def clone
    DiskGrid.new(@nodes.map { |k,v| v.clone })
  end
end

class Step 
  class << self
    @shortest_path = 0
    attr_reader :shortest_path
  end

  def initialize(step, grid)
    @step = step
    @grid = grid
  end

  def take_step(target)

    start = @grid.nodes.select { |k, n| n.is_empty? }
    start_node = start.first[1]
    neighbours = Coordinate.neighbours(
      start_node.position, @grid.max_x, @grid.max_y
      ).map {|c| @grid.nodes[c] }
       .select {|n| start_node.has_space_for(n) }

    new_grids = neighbours.map do |orig_neighbour|
      new_grid = @grid.clone
      orig_empty = new_grid.nodes[start_node.position]
      new_neighbour = new_grid.nodes[orig_neighbour.position]
      new_grid.nodes[orig_empty.position].take_data_from(new_neighbour)
      new_empty = new_grid.nodes.select { |k, n| n.is_empty? }
      new_grid
    end

    new_grids.map { |e| Step(@step+1, e.clone) }
  end
end

class EmptyToGoalPathFinder
  def initialize(grid, target)
    @grid = grid
  end

  def find_path
    

  end
end

class Coordinate
  def self.neighbours(coord, max_x, max_y)
    candidates = [
      [coord[0]-1, coord[1]],
      [coord[0]+1, coord[1]],
      [coord[0], coord[1]-1],
      [coord[0], coord[1]+1]
    ]
    
    candidates
      .reject { |c| c[0]<0 }
      .reject { |c| c[1]<0 }
      .reject { |c| c[0]>max_x }
      .reject { |c| c[1]>max_y }
  end
end