require_relative('../disk_grid.rb')

describe "grid parsing and display" do
  it "can be cloned" do
     input = [
'Filesystem            Size  Used  Avail  Use%',
'/dev/grid/node-x0-y0   10T    8T     2T   80%',
'/dev/grid/node-x0-y1   11T    6T     5T   54%',
'/dev/grid/node-x0-y2   32T   28T     4T   87%',
'/dev/grid/node-x1-y0    9T    7T     2T   77%',
'/dev/grid/node-x1-y1    8T    0T     8T    0%',
'/dev/grid/node-x1-y2   11T    7T     4T   63%',
'/dev/grid/node-x2-y0   10T    6T     4T   60%',
'/dev/grid/node-x2-y1    9T    8T     1T   88%',
'/dev/grid/node-x2-y2    9T    6T     3T   66%'
    ]
    nodes = DiskNode.parse_many(input)
    grid = DiskGrid.new(nodes)
    grid_two = grid.clone

    expect(grid).not_to be grid_two     
  end

  it "can organise the grid" do
    input = [
'Filesystem            Size  Used  Avail  Use%',
'/dev/grid/node-x0-y0   10T    8T     2T   80%',
'/dev/grid/node-x0-y1   11T    6T     5T   54%',
'/dev/grid/node-x0-y2   32T   28T     4T   87%',
'/dev/grid/node-x1-y0    9T    7T     2T   77%',
'/dev/grid/node-x1-y1    8T    0T     8T    0%',
'/dev/grid/node-x1-y2   11T    7T     4T   63%',
'/dev/grid/node-x2-y0   10T    6T     4T   60%',
'/dev/grid/node-x2-y1    9T    8T     1T   88%',
'/dev/grid/node-x2-y2    9T    6T     3T   66%'
    ]
    nodes = DiskNode.parse_many(input)
    grid = DiskGrid.new(nodes)

    # ( 8T/10T) --  7T/ 9T -- [ 6T/10T]
    #     |           |           |
    #   6T/11T  --  0T/ 8T --   8T/ 9T
    #     |           |           |
    #  28T/32T  --  7T/11T --   6T/ 9T
    expect(grid.nodes[[0,0]].name).to eq 'node-x0-y0'
    expect(grid.nodes[[0,1]].name).to eq 'node-x0-y1'
    expect(grid.nodes[[0,2]].name).to eq 'node-x0-y2'
    expect(grid.nodes[[1,0]].name).to eq 'node-x1-y0'
    expect(grid.nodes[[1,1]].name).to eq 'node-x1-y1'
    expect(grid.nodes[[1,2]].name).to eq 'node-x1-y2'
    expect(grid.nodes[[2,0]].name).to eq 'node-x2-y0'
    expect(grid.nodes[[2,1]].name).to eq 'node-x2-y1'
    expect(grid.nodes[[2,2]].name).to eq 'node-x2-y2'
  end

  it "can pretty print the grid" do
        input = [
'Filesystem            Size  Used  Avail  Use%',
'/dev/grid/node-x0-y0   10T    8T     2T   80%',
'/dev/grid/node-x0-y1   11T    6T     5T   54%',
'/dev/grid/node-x0-y2   32T   28T     4T   87%',
'/dev/grid/node-x1-y0    9T    7T     2T   77%',
'/dev/grid/node-x1-y1    8T    0T     8T    0%',
'/dev/grid/node-x1-y2   11T    7T     4T   63%',
'/dev/grid/node-x2-y0   10T    6T     4T   60%',
'/dev/grid/node-x2-y1    9T    8T     1T   88%',
'/dev/grid/node-x2-y2    9T    6T     3T   66%'
    ]
      nodes = DiskNode.parse_many(input)
      grid = DiskGrid.new(nodes)
      grid_display = grid.pretty_print

      expect(grid_display).to eq [
        '(.) .  G ',
        ' .  _  . ',
        ' #  .  # '
      ]

      puts grid_display.join("\n")
  end
end