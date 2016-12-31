require_relative('../simulator.rb')

# --- Part Two ---

# After getting the first capsule (it contained a star! what great fortune!), the machine detects your success and begins to rearrange itself.

# When it's done, the discs are back in their original configuration
# as if it were time=0 again, but a new disc with 11 positions
# and starting at position 0 has appeared exactly one second below the previously-bottom disc.

# With this new disc, and counting again starting from time=0
# with the configuration in your puzzle input, what is the first time you can press the button to get another capsule?

# Although it hasn't changed, you can still get your puzzle input.

describe "day 15 part two" do
  it "can solve part two" do
    disks = [
      {number_of_positions: 17, starting_position: 1},
      {number_of_positions: 7, starting_position: 0},
      {number_of_positions: 19, starting_position: 2},
      {number_of_positions: 5, starting_position: 0},
      {number_of_positions: 3, starting_position: 0},
      {number_of_positions: 13, starting_position: 5},
      {number_of_positions: 11, starting_position: 0}
    ]

    simulation_result = SculptureSimulator.simulate(disks.clone)

    SculptureSimulator.simulate_at_tick(disks.clone, simulation_result)
    p "to solve part two press the button at #{simulation_result}"
  end
end