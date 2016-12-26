require_relative('../map.rb')

# --- Day 24: Air Duct Spelunking ---

# You've finally met your match; the doors that provide access to the roof
# are locked tight, and all of the controls and related electronics are
# inaccessible. You simply can't reach them.

# The robot that cleans the air ducts, however, can.

# It's not a very fast little robot, but you reconfigure it to be able to
# interface with some of the exposed wires that have been routed through
# the HVAC system. If you can direct it to each of those locations, you should
# be able to bypass the security controls.

# You extract the duct layout for this area from some blueprints you acquired
# and create a map with the relevant locations marked (your puzzle input).
# 0 is your current location, from which the cleaning robot embarks;
# the other numbers are (in no particular order) the locations the robot
# needs to visit at least once each. Walls are marked as #, and open passages
# are marked as .. Numbers behave like open passages.

# For example, suppose you have a map like the following:

# ###########
# #0.1.....2#
# #.#######.#
# #4.......3#
# ###########

# To reach all of the points of interest as quickly as possible, you would have
# the robot take the following path:

# 0 to 4 (2 steps)
# 4 to 1 (4 steps; it can't move diagonally)
# 1 to 2 (6 steps)
# 2 to 3 (2 steps)
# Since the robot isn't very fast, you need to find it the shortest route.
# This path is the fewest steps (in the above example, a total of 14)
# required to start at 0 and then visit every other location at least once.

# Given your actual map, and starting from location 0, what is the fewest
# number of steps required to visit every non-0 number marked on the map at
# least once?

describe "day 24 - part one" do
      let(:map) { map = Map.parse(%{
###########
#0.1.....2#
#.#######.#
#4.......3#
###########
      })}

  it "solve the example input" do
    paths = map.simulate
    paths.select { |p| p.numbers_still_to_reach.empty? }

    puts "there are #{paths.length} paths"

    puts "path 0 nums to reach = '#{paths[0].numbers_still_to_reach}'"
    puts paths[0].pretty_print(map).join("\n")

    puts "path 0 nums to reach = '#{paths[1].numbers_still_to_reach}'"
    puts paths[1].pretty_print(map).join("\n")
  end
end