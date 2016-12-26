require_relative('../map.rb')



describe "the map" do
    let(:map) { map = Map.parse(%{
###########
#0.1.....2#
#.#######.#
#4.......3#
###########})}

  it "can parse the map" do
    expect(map.max_number).to eq 4
    expect(map.pretty_print).to eq(%{###########
#0.1.....2#
#.#######.#
#4.......3#
###########})
  end

  it "can find the starting point" do
    expect(map.starting_coordinate).to eq [1,1]
  end

  it "can generate options for the next step" do
    step_zero = Step.new(map.starting_coordinate)
    path = Path.new(map.numbers_to_reach)
    path.add_step(step_zero)
    first_step_paths = map.next_step_from([path])

    expect(first_step_paths.map { |e| e.steps.map { |e| e.coordinate }}).to match_array [
      [[1,1], [1,2]],
      [[1,1], [2,1]]
    ]
  end

  it "can check if it has reached a number" do
    step_zero = Step.new(map.starting_coordinate)
    path = Path.new(map.numbers_to_reach)
    path.add_step(step_zero)

    starting_state = [path].select { |p| p.numbers_still_to_reach.include? 4}
    expect(starting_state.length).to eq 1

    first_step_paths = map.next_step_from([path])
    second_step_paths = map.next_step_from(first_step_paths)


    paths_as_steps = second_step_paths.map { |e| e.steps.map { |e| e.coordinate } }
    expect(paths_as_steps).to match_array [
      [[1,1], [1,2], [1,3]],
      [[1,1], [1,2], [1,1]],
      [[1,1], [2,1], [3,1]],
      [[1,1], [2,1], [1,1]]
    ]

    reached_four = second_step_paths.select { |p| p.numbers_still_to_reach.include? 4}
    expect(reached_four.length).to eq 0
  end

  it "can count the number of steps" do
    step_zero = Step.new(map.starting_coordinate)
    path = Path.new(map.numbers_to_reach)
    path.add_step(step_zero)
    first_step_paths = map.next_step_from([path])
    second_step_paths = map.next_step_from(first_step_paths)
    third_step_paths = map.next_step_from(second_step_paths)

    expect(third_step_paths.any? {|p| p.steps.length == 4}).to eq true
  end

  it "can walk a path along the top corridor" do  
    step_zero = Step.new(map.starting_coordinate)
    path = Path.new(map.numbers_to_reach)
    path.add_step(step_zero)
    first_step_paths = map.next_step_from([path])
    second_step_paths = map.next_step_from(first_step_paths)
    third_step_paths = map.next_step_from(second_step_paths)
    fourth_step_paths = map.next_step_from(third_step_paths)
    
    fourths = fourth_step_paths.map { |p| p.steps.map {|s| s.coordinate } }
    expect(fourths.any? {|f| f.include? [4, 1]}).to eq true

    five_step_paths = map.next_step_from(fourth_step_paths)
    
    fives = five_step_paths.map { |p| p.steps.map {|s| s.coordinate } }
    expect(fives.any? {|f| f.include? [5, 1]}).to eq true

    ssp = map.next_step_from(five_step_paths)
    sesp = map.next_step_from(ssp)
    esp = map.next_step_from(sesp)
    nsp = map.next_step_from(esp)

    nines = nsp.map { |p| p.steps.map {|s| s.coordinate } }
    expect(nines.any? {|f| f.include? [9, 1]}).to eq true

    expect(nsp[0].numbers_still_to_reach).to match_array [3]
  end
end