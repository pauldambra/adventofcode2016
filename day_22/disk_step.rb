class DiskStep 
  attr_reader :step

  class << self
    @shortest_path = 0
    attr_reader :shortest_path
  end

  attr_reader :grid

  def initialize(step, grid)
    @step = step
    @grid = grid.clone
  end

  def take_step(neighbours, target)

    neighbours_with_space = neighbours
        .map {|c| @grid.nodes[c] }
        .select {|n| @grid.empty_node.has_space_for(n) }

    new_grids = neighbours_with_space.map do |orig_neighbour|
      new_grid = @grid.clone
      orig_empty = new_grid.nodes[@grid.empty_node.position]
      new_neighbour = new_grid.nodes[orig_neighbour.position]
      new_grid.nodes[orig_empty.position].take_data_from(new_neighbour)
      new_empty = new_grid.nodes.select { |k, n| n.is_empty? }
      new_grid
    end

    new_grids.map { |e| DiskStep.new(@step+1, e) }
  end
end