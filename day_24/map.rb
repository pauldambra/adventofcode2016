require_relative('../common/coordinate.rb')
require_relative('./path.rb')
require_relative('./step.rb')

class Map
  attr_reader :max_number
  attr_reader :starting_coordinate
  attr_reader :map

  def initialize(i)
    @numbers = []
    @starting_coordinate

    positions = i.lines
                    .map(&:chomp)
                    .reject { |x| x.length == 0 }
                    .map { |l| l.chars }
    @map = positions.map.with_index do |l, y| 
      row = []
      l.map.with_index do |c, x|  
        if /\d+/ =~ c
          n = c.to_i
          row.push(n)
          @numbers.push(n)
          @starting_coordinate = [x,y] if n == 0
        else
          row.push(c)
        end
      end
      row
    end

    @max_number = @numbers.max
    @max_x = @map[0].length - 1
    @max_y = @map.length - 1
  end

  def numbers_to_reach
    (0..@max_number).to_a
  end

  def pretty_print
    @map.map { |e| e.join('') }
        .join("\n")
  end

  def simulate
    has_reached_target = false

    path = coord_to_step_on_path(@starting_coordinate, Path.new(numbers_to_reach))
    paths = [path]

    halt_count = 0
    loop do
      paths = next_step_from(paths)
      # p paths.inspect
      # p "outs: #{paths.map {|p| p.numbers_still_to_reach}}"
      has_reached_target = paths.any? { |p| p.numbers_still_to_reach.empty? }

      halt_count += 1
      break if has_reached_target || halt_count == 10
    end

    reached_target = paths.select { |p| p.numbers_still_to_reach.empty? }
    reached_target.sort_by { |p| p.steps.length }
  end

  # each path has a most recent step. which is turned into possible next steps
  # each possible next step is mapped onto a new copy of the path leading to it
  # added to its path and returned
  def next_step_from(paths)
      paths.map do |path|
        possible_neighbours(path.most_recent_step.coordinate, @max_x, @max_y) 
          .map { |c| coord_to_step_on_path(c, path) }
          .reject { |p| p == nil }
      end
      .flatten
  end

  def self.parse(i)
    Map.new(i)
  end

  def coord_to_step_on_path(c, path)
    place = @map[c[1]][c[0]]
    # p "for #{c} got #{place}"
    step = Step.new(c)
    # p "nstr #{numbers_still_to_reach}"

    # p "step created as #{step.inspect}"
    clone_path_with_new_step(path, step, place)
  end

  private 
  def clone_path_with_new_step(path, step, place)
    new_path = path.clone
    step = step.clone

    step.passage_content = place
    new_path.add_step(step)
    
    new_path
  rescue RevisitingPath
    # p "culling invalid path with revisited step #{step.inspect}"
    nil
  end

  def possible_neighbours(coord, max_x, max_y)
    c = Coordinate
          .neighbours(coord, max_x, max_y)
          .reject {|c| @map[c[1]][c[0]] == '#' }
    # p "cs #{c}"
    c
  end

end