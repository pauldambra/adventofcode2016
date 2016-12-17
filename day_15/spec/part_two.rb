
# --- Part Two ---

# After getting the first capsule (it contained a star! what great fortune!), the machine detects your success and begins to rearrange itself.

# When it's done, the discs are back in their original configuration
# as if it were time=0 again, but a new disc with 11 positions
# and starting at position 0 has appeared exactly one second below the previously-bottom disc.

# With this new disc, and counting again starting from time=0
# with the configuration in your puzzle input, what is the first time you can press the button to get another capsule?

# Although it hasn't changed, you can still get your puzzle input.

require 'timeout'

RSpec.configure do |c|
  c.around(:each) do |example|
    Timeout::timeout(1800) {
      example.run
    }
  end
end

describe "day 15 part two" do
  it "can solve part two" do
    simulaton_result = SculptureSimulator.simulate([
      Disk.new(0, 17, 1),
      Disk.new(1, 7, 0),
      Disk.new(2, 19, 2),
      Disk.new(3, 5, 0),
      Disk.new(4, 3, 0),
      Disk.new(5, 13, 5),
      Disk.new(6, 11, 0)
      ])

    p "button press should be at time #{simulaton_result}"
    
    sculpture_result = Sculpture.new([
      Disk.new(0, 17, 1),
      Disk.new(1, 7, 0),
      Disk.new(2, 19, 2),
      Disk.new(3, 5, 0),
      Disk.new(4, 3, 0),
      Disk.new(5, 13, 5),
      Disk.new(6, 11, 0)
      ]).press_button_at_time simulaton_result

    expect(sculpture_result.key? :falls_through).to eq true
  end
end