require_relative('../../assembunny/computer.rb')

# --- Day 23: Safe Cracking ---

# This is one of the top floors of the nicest tower in EBHQ. The Easter Bunny's
# private office is here, complete with a safe hidden behind a painting,
# and who wouldn't hide a star in a safe behind a painting?

# The safe has a digital screen and keypad for code entry. A sticky note
# attached to the safe has a password hint on it: "eggs". The painting is of
# a large rabbit coloring some eggs. You see 7.

# When you go to type the code, though, nothing appears on the display; instead,
# the keypad comes apart in your hands, apparently having been smashed.
# Behind it is some kind of socket - one that matches a connector in your
# prototype computer! You pull apart the smashed keypad and extract
# the logic circuit, plug it into your computer, and plug your computer
# into the safe.

# Now, you just need to figure out what output the keypad would have sent
# to the safe. You extract the assembunny code from the logic chip
# (your puzzle input).
# The code looks like it uses almost the same architecture and instruction
# set that the monorail computer used! You should be able to use the same
# assembunny interpreter for this as you did there, but with one new
# instruction:

# tgl x toggles the instruction x away (pointing at instructions like jnz does:
# positive means forward; negative means backward):

# For one-argument instructions, inc becomes dec, and all other one-argument
# instructions become inc.
# For two-argument instructions, jnz becomes cpy, and all other
# two-instructions become jnz.
# The arguments of a toggled instruction are not affected.
# If an attempt is made to toggle an instruction outside the program,
# nothing happens.
# If toggling produces an invalid instruction (like cpy 1 2) and an attempt
# is later made to execute that instruction, skip it instead.
# If tgl toggles itself (for example, if a is 0, tgl a would target itself
# and become inc a), the resulting instruction is not executed until the next
# time it is reached.
# For example, given this program:

# cpy 2 a
# tgl a
# tgl a
# tgl a
# cpy 1 a
# dec a
# dec a
#
# cpy 2 a initializes register a to 2.
# The first tgl a toggles an instruction a (2) away from it, which changes
# the third tgl a into inc a.
# The second tgl a also modifies an instruction 2 away from it, which changes
# the cpy 1 a into jnz 1 a.
# The fourth line, which is now inc a, increments a to 3.
# Finally, the fifth line, which is now jnz 1 a, jumps a (3) instructions ahead,
# skipping the dec a instructions.
# In this example, the final value in register a is 3.

# The rest of the electronics seem to place the keypad entry (the number of
# eggs, 7) in register a, run the code, and then send the value left in
# register a to the safe.

# What value should be sent to the safe?

# require 'timeout'

# RSpec.configure do |c|
#   c.around(:each) do |example|
#     Timeout::timeout(180) {
#       example.run
#     }
#   end
# end

describe "day 23 - part one" do
    let(:computer) { computer = Computer.new({
      a: 7,
      b: 0,
      c: 0,
      d: 0
      })
  }

  it "can toggle instructions" do
    computer.execute(Computer.parse(%{
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a}))
    expect(computer.registers[:a]).to eq 3
  end

  it "can solve the puzzle_input" do
    computer.execute(Computer.parse(%{
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 89 c
jnz 84 d
inc a
inc d
jnz d -2
inc c
jnz c -5}))
    p "input value from register a which is #{computer.registers[:a]}"
  end
end