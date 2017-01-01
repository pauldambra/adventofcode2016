require_relative('../disk_grid.rb')
require_relative('../disk_node.rb')

describe "getting the empty disk to the goal" do
  it "can find a path" do

# makes a grid like this:
#     (.) .  #  G
#      .  _  .  #
#      #  .  #  #
#      #  #  #  #

    input = [
      'Filesystem            Size  Used  Avail  Use%',
      '/dev/grid/node-x0-y0   10T    8T     2T   80%',
      '/dev/grid/node-x0-y1   11T    6T     5T   54%',
      '/dev/grid/node-x0-y2   32T   28T     4T   87%',
      '/dev/grid/node-x0-y3   32T   28T     4T   87%',
      '/dev/grid/node-x1-y0    9T    7T     2T   77%',
      '/dev/grid/node-x1-y1    8T    0T     8T    0%',
      '/dev/grid/node-x1-y2   11T    7T     4T   63%',
      '/dev/grid/node-x1-y3   11T    7T     4T   63%',
      '/dev/grid/node-x2-y0   10T    6T     4T   60%',
      '/dev/grid/node-x2-y1    9T    8T     1T   88%',
      '/dev/grid/node-x2-y2    9T    6T     3T   66%',
      '/dev/grid/node-x2-y3    9T    6T     3T   66%',
      '/dev/grid/node-x3-y0   10T    6T     4T   60%',
      '/dev/grid/node-x3-y1    9T    8T     1T   88%',
      '/dev/grid/node-x3-y2    9T    6T     3T   66%',
      '/dev/grid/node-x3-y3    9T    6T     3T   66%'
    ]
    nodes = DiskNode.parse_many(input)
    grid = DiskGrid.new(nodes)
    grid.desired_data_node = [grid.max_x,0]

    puts grid.pretty_print

    finder = EmptyToGoalPathFinder.new

    target_step = finder.find_path(grid)

    puts "have a candidate end state"
    puts target_step.grid.pretty_print

    expect(target_step.grid.empty_node.position).to eq [1,0]

    puts "took #{target_step.step} steps to get to this point"
  end
end