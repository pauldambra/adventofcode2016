require_relative('../multiply_instruction_optimiser.rb')
require_relative('../add_instruction_optimiser.rb')
require_relative('../computer.rb')

# --- Day 25: Clock Signal ---

# You open the door and find yourself on the roof. The city sprawls away from
# you for miles and miles.

# There's not much time now - it's already Christmas, but you're nowhere near
# the North Pole, much too far to deliver these stars to the sleigh in time.

# However, maybe the huge antenna up here can offer a solution. After all, the
# sleigh doesn't need the stars, exactly; it needs the timing data they provide,
# and you happen to have a massive signal generator right here.

# You connect the stars you have to your prototype computer, connect that to the
# antenna, and begin the transmission.

# Nothing happens.

# You call the service number printed on the side of the antenna and quickly
# explain the situation. "I'm not sure what kind of equipment you have connected
# over there," he says, "but you need a clock signal." You try to explain that
# this is a signal for a clock.

# "No, no, a clock signal - timing information so the antenna computer knows how
# to read the data you're sending it. An endless, alternating pattern of
# 0, 1, 0, 1, 0, 1, 0, 1, 0, 1...." He trails off.

# You ask if the antenna can handle a clock signal at the frequency you would
# need to use for the data from the stars. "There's no way it can! The only
# antenna we've installed capable of that is on top of a top-secret Easter Bunny
# installation, and you're definitely not-" You hang up the phone.

# You've extracted the antenna's clock signal generation assembunny code
# (your puzzle input); it looks mostly compatible with code you worked on just
# recently.

# This antenna code, being a signal generator, uses one extra instruction:

# out x transmits x (either an integer or the value of a register) as the next
# value for the clock signal.
# The code takes a value (via register a) that describes the signal to generate,
# but you're not sure how it's used. You'll have to find the input to produce
# the right signal through experimentation.

# What is the lowest positive integer that can be used to initialize register a
# and cause the code to output a clock signal of 0, 1, 0, 1... repeating
# forever?

puzzle_input = [
  'cpy a d',
  'cpy 9 c',
  'cpy 282 b',
  'inc d',
  'dec b',
  'jnz b -2',
  'dec c',
  'jnz c -5',
  'cpy d a',
  'jnz 0 0',
  'cpy a b',
  'cpy 0 a',
  'cpy 2 c',
  'jnz b 2',
  'jnz 1 6',
  'dec b',
  'dec c',
  'jnz c -4',
  'inc a',
  'jnz 1 -7',
  'cpy 2 b',
  'jnz c 2',
  'jnz 1 4',
  'dec b',
  'dec c',
  'jnz 1 -4',
  'jnz 0 0',
  'out b',
  'jnz a -19',
  'jnz 1 -21'
]

describe "day 25 - part one" do
  it "finds mults in the instructions?" do
    MultiplyInstructionOptimiser.optimise(puzzle_input)
    expect(puzzle_input.any? {|pi| pi.include? 'mult'}).to be true
  end

  it "can have an output" do
    computer = Computer.new({
      a: 7,
      b: 0,
      c: 0,
      d: 0
      })
    computer.execute(Computer.parse(%{
out a}))
    expect(computer.out_signal).to eq [7]
  end

  # it "can find alternating strings of 010101" do
  #   expect(is_alternating('01010101010101010101010101')).to be true
  #   expect(is_alternating('01010101110101010101010101')).to be false
  # end

  it "can probe for desired string" do
    initial_a = -1

    loop do
      initial_a += 1

      computer = Computer.new({
                  a: initial_a,
                  b: 0,
                  c: 0,
                  d: 0
                  })

      was_alternating = computer.execute(puzzle_input)

      p "initialising register a with #{initial_a}"
      p "output signal #{computer.out_signal} was alternating signal? #{was_alternating}"

      break if was_alternating
    end

    p "lowest value to initialize a is #{initial_a}"
  end

  # it "can cheat" do
  #   #instructions do 9 * 282 = 
  #   i = 2538
  #   x = -1
  #   loop do
  #     x += 1
  #     binary_representation = ("%b" % (x + i))
  #     p "rep for #{x} is #{binary_representation}"
  #     break if binary_representation == '010101010101'
  #     break if x == 1400000
  #   end
  # end

  # def is_alternating(s)
  #   cs = s.chars
  #   evens_are_zeroes = cs.select.with_index { |_, i| i.even? }
  #                               .all? { |c| c == '0' }
  #   odds_are_ones = cs.select.with_index { |_, i| i.odd? }
  #                               .all? { |c| c == '1' }
  #   evens_are_zeroes && odds_are_ones
  # end
end








