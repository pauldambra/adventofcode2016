require_relative('../sculpture.rb')
require_relative('../disk.rb')

require 'timeout'

RSpec.configure do |c|
  c.around(:each) do |example|
    Timeout::timeout(20) {
      example.run
    }
  end
end

# --- Day 15: Timing is Everything ---

# The halls open into an interior plaza containing a large kinetic
# sculpture. The sculpture is in a sealed enclosure and seems to
# involve a set of identical spherical capsules that are carried
# to the top and allowed to bounce through the maze of spinning pieces.

# Part of the sculpture is even interactive! When a button is pressed,
# a capsule is dropped and tries to fall through slots in a set
# of rotating discs to finally go through a little hole at the bottom
# and come out of the sculpture. If any of the slots aren't aligned
# with the capsule as it passes, the capsule bounces off the disc
# and soars away. You feel compelled to get one of those capsules.

# The discs pause their motion each second and come in different sizes;
# they seem to each have a fixed number of positions at which they
# stop. You decide to call the position with the slot 0, and count
# up for each position it reaches next.

# Furthermore, the discs are spaced out so that after you push
# the button, one second elapses before the first disc is reached,
# and one second elapses as the capsule passes from one disc to
# the one below it. So, if you push the button at time=100, then the
# capsule reaches the top disc at time=101, the second disc
# at time=102, the third disc at time=103, and so on.

# The button will only drop a capsule at an integer time - no
# fractional seconds allowed.

# For example, at time=0, suppose you see the following
# arrangement:

# Disc #1 has 5 positions; at time=0, it is at position 4.
# Disc #2 has 2 positions; at time=0, it is at position 1.
# If you press the button exactly at time=0, the capsule would start
# to fall; it would reach the first disc at time=1. Since the first
# disc was at position 4 at time=0, by time=1 it has ticked one
# position forward. As a five-position disc, the next position is 0,
# and the capsule falls through the slot.

# Then, at time=2, the capsule reaches the second disc.
# The second disc has ticked forward two positions at this point:
# it started at position 1, then continued to position 0,
# and finally ended up at position 1 again. Because there's only
# a slot at position 0, the capsule bounces away.

# If, however, you wait until time=5 to push the button,
# then when the capsule reaches each disc, the first disc will
# have ticked forward 5+1 = 6 times (to position 0), and the
# second disc will have ticked forward 5+2 = 7 times
# (also to position 0). In this case, the capsule would fall
# through the discs and come out of the machine.

# However, your situation has more than two discs; you've noted
# their positions in your puzzle input. What is the first time
# you can press the button to get a capsule?

puzzle_input = %{
Disc #1 has 17 positions; at time=0, it is at position 1.
Disc #2 has 7 positions; at time=0, it is at position 0.
Disc #3 has 19 positions; at time=0, it is at position 2.
Disc #4 has 5 positions; at time=0, it is at position 0.
Disc #5 has 3 positions; at time=0, it is at position 0.
Disc #6 has 13 positions; at time=0, it is at position 5.
}

def generate_candidates

end

describe "with two disks" do
  it "can find when they are at 0 at consecutive seconds" do
    sculpture = Sculpture.new([
      Disk.new(5, 4),
      Disk.new(2, 1)
      ])

    result = sculpture.find_time_to_press_button
    expect(result).to eq 5

  end
end

describe "day 15 part one" do
  xit "can push example sculpture button at time 0" do
    sculpture = Sculpture.new([
      Disk.new(5, 4),
      Disk.new(2, 1)
      ])

    expect(sculpture.press_button_at_time(0)).to eq bounced_away_at: 2
  end

  xit "can push example sculpture button at time 5" do
    sculpture = Sculpture.new([
      Disk.new(5, 4),
      Disk.new(2, 1)
      ])

    expect(sculpture.press_button_at_time(5)).to eq falls_through: 7
  end

  it "can find the time to push the button" do
    disk_one = Disk.new(17, 1)
    sculpture = Sculpture.new([
      disk_one,
      Disk.new(7, 0),
      Disk.new(19, 2),
      Disk.new(5, 0),
      Disk.new(3, 0),
      Disk.new(13, 5),
      ])

    result = sculpture.find_time_to_press_button
    p "result is?? #{result}"
  end
end