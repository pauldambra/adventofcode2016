require_relative('./step.rb')

class EmptyToGoalPathFinder
  attr_reader :visited_nodes

  def initialize()
    @visited_nodes = Set.new
  end

  def find_path(starting_grid, target)

    # def step_empty_to_goal
    #   EmptyToGoalPathFinder.new(self, @desired_data_node).find_path
    # end

    zeroth_step = Step.new(0, starting_grid)
    next_steps = zeroth_step.take_step(target)

    next_steps = next_steps.reject { |ns| @visited_nodes.include? ns.grid.empty_node.position }
    next_steps.each do|ns| 
      @visited_nodes.add(ns.grid.empty_node.position) 
      puts ns.grid.pretty_print 
      puts "empty node is at #{ns.grid.empty_node.position}"
      puts "empty node is adjacent to goal? #{ns.grid.empty_node_is_adjacent_to_goal?}"
      puts '-------------'
    end
    next_steps.select { |ns| ns.grid.empty_node_is_adjacent_to_goal? }
  end
end