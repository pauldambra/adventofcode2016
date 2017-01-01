require_relative('../common/coordinate.rb')
require_relative('./path_finder.rb')

class DiskGrid
  attr_reader :nodes
  attr_reader :max_x
  attr_reader :max_y
  attr_accessor :desired_data_node

  def initialize(nodes)
    @max_x = nodes.max { |a, b| a.position[0]<=>b.position[0] }.position[0]
    @max_y = nodes.max { |a, b| a.position[1]<=>b.position[1] }.position[1]

    # @desired_data_node = [@max_x, 0]

    @nodes = Hash.new
    nodes.each do |node|
      @nodes[node.position] = node
    end
  end

  def empty_node
    start = @nodes.select { |k, n| n.is_empty? }
    start.first[1]
  end

  def copy_desired_data_to_empty_node
    current_empty = empty_node
    current_empty_position = current_empty.position
    @nodes[current_empty_position].take_data_from(@nodes[@desired_data_node])
    clone_with_new_desired_data_location(current_empty_position)    
  end

  def clone_with_new_desired_data_location(location)
    new_grid = clone
    new_grid.desired_data_node = location
    new_grid
  end

  def pretty_print
    rows = []
    (0..@max_y).each do |y|
      cols = (0..@max_x).map do |x|
        node = @nodes[[x,y]]
        neighbours = get_neighbours [x,y]

        if [x,y] == @desired_data_node
          ' G '
        elsif [x,y] == [0,0]
          '(.)'
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
    new_grid = DiskGrid.new(@nodes.map { |k,v| v.clone })
    new_grid.desired_data_node = @desired_data_node.clone
    new_grid
  end
end