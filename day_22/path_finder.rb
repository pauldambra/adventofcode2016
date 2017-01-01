require_relative('./disk_step.rb')
require_relative('../common/coordinate.rb')

class EmptyToGoalPathFinder
  attr_reader :visited_nodes

  def initialize()
    @visited_nodes = Set.new
  end

  # assumes that the desired node is top right
  # and the eventual goal is top left
  def find_path(starting_grid)

    starting_step = DiskStep.new(0, starting_grid)

    loop do
      target = [starting_step.grid.desired_data_node[0]-1, 0] #to the left of the desired data

      next_steps = [starting_step]
      loop do
        next_steps = get_empty_node_next_to_desired_data(next_steps, target)

        raise "found no next steps? target is #{target}" if next_steps.empty?
        break if next_steps.any? { |ns| ns.grid.empty_node.position == target }
      end

      starting_step = move_desired_data_into_empty_node(next_steps, target)
      @visited_nodes = Set.new # for new empty node path search

      break if starting_step.grid.desired_data_node == [0,0]
    end
    starting_step
  end

  def move_desired_data_into_empty_node(next_steps, target)
    seed_step = next_steps.select { |ns| ns.grid.empty_node.position == target }[0]

    moved_data_grid = seed_step.grid.copy_desired_data_to_empty_node
    moved_data_step = DiskStep.new(seed_step.step+1, moved_data_grid)
    # puts "moved data after #{moved_data_step.step} steps"
    # puts moved_data_step.grid.pretty_print
    moved_data_step
  end

  def get_empty_node_next_to_desired_data(steps, toward)
    steps.map do |s|
      empty_node = s.grid.empty_node
      
      neighbours = Coordinate.neighbours(empty_node.position, s.grid.max_x, s.grid.max_y)
      neighbours = neighbours.reject  { |n| @visited_nodes.include? n }
      neighbours = neighbours.reject  { |n| n == s.grid.desired_data_node }

      next_steps = s.take_step(neighbours, toward)

      next_steps = next_steps.reject { |ns| @visited_nodes.include? ns.grid.empty_node.position }
      next_steps.each do|ns| 
        @visited_nodes.add(ns.grid.empty_node.position) 
        # puts ns.grid.pretty_print 
        # puts "empty node is at #{ns.grid.empty_node.position}"
        # puts '-------------'
      end
      next_steps
    end
    .flatten
  end
end