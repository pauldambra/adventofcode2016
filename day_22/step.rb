class Step 
  class << self
    @shortest_path = 0
    attr_reader :shortest_path
  end

  attr_reader :grid

  def initialize(step, grid)
    @step = step
    @grid = grid.clone
  end

  def take_step(target)

    start_node = @grid.empty_node
    p "start node #{start_node}"

    neighbours_with_space = Coordinate.neighbours(
      start_node.position, @grid.max_x, @grid.max_y
      ).map {|c| @grid.nodes[c] }
       .select {|n| start_node.has_space_for(n) }

    new_grids = neighbours_with_space.map do |orig_neighbour|
      new_grid = @grid.clone
      orig_empty = new_grid.nodes[start_node.position]
      new_neighbour = new_grid.nodes[orig_neighbour.position]
      new_grid.nodes[orig_empty.position].take_data_from(new_neighbour)
      new_empty = new_grid.nodes.select { |k, n| n.is_empty? }
      new_grid
    end

    new_grids.map { |e| Step.new(@step+1, e) }
  end
end