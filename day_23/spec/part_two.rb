require_relative('../../assembunny/computer.rb')

# --- Part Two ---

# The safe doesn't open, but it does make several angry noises to express
# its frustration.

# You're quite sure your logic is working correctly, so the only other
# thing is... you check the painting again. As it turns out, colored eggs
# are still eggs. Now you count 12.

# As you run the program with this new input, the prototype computer begins
# to overheat. You wonder what's taking so long, and whether the lack of any
# instruction more powerful than "add one" has anything to do with it.
# Don't bunnies usually multiply?

# Anyway, what value should actually be sent to the safe?

describe "day 23 - part two" do
  let(:computer) { computer = Computer.new({
    a: 12,
    b: 0,
    c: 0,
    d: 0
    })
  }

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