class RevisitingPath < StandardError; end

class Path
  attr_reader :steps
  attr_reader :most_recent_step
  attr_reader :numbers_still_to_reach

  @@construction_count = 0
  @path_id

  def initialize(numbers_still_to_reach)
    @steps = []
    @numbers_still_to_reach = numbers_still_to_reach

    @path_id = @@construction_count
    @@construction_count += 1
  end

  def add_step(step)
    if step.passage_content.is_a? Fixnum
      # p "path is adding step #{step.coordinate} at number #{step.passage_content}"
      @numbers_still_to_reach.delete(step.passage_content)
      # p "leaves #{@numbers_still_to_reach}"
    end

    step.numbers_still_to_reach = @numbers_still_to_reach

    raise RevisitingPath if @steps.include? step

    @most_recent_step = step
    @steps.push(step)

    puts self
  end

  def pretty_print(map)
    grid = map.pretty_print.lines.map(&:chomp).map { |pp| pp.chars }
    steps.each do |step|
      c = step.coordinate
      was_num = step.passage_content.is_a? Fixnum
      output = was_num ? 'X' : '*'
      grid[c[1]][c[0]] = output
    end

    grid.map { |e| e.join('') }
  end

  def clone
    p = Path.new(@numbers_still_to_reach)
    @steps.each { |s| p.add_step(s.clone) }
    p
  end

  def to_s
    "id: #{@path_id} route #{@steps.map { |s| s.coordinate }}"
  end
end