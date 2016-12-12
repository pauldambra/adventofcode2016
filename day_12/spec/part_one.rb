

# --- Day 12: Leonardo's Monorail ---

# You finally reach the top floor of this building: a garden with a slanted glass ceiling. Looks like there are no more stars to be had.

# While sitting on a nearby bench amidst some tiger lilies, you manage to decrypt some of the files you extracted from the servers downstairs.

# According to these documents, Easter Bunny HQ isn't just this building - it's a collection of buildings in the nearby area. They're all connected by a local monorail, and there's another building not far from here! Unfortunately, being night, the monorail is currently not operating.

# You remotely connect to the monorail control systems and discover that the boot sequence expects a password. The password-checking logic (your puzzle input) is easy to extract, but the code it uses is strange: it's assembunny code designed for the new computer you just assembled. You'll have to execute the code and get the password.

# The assembunny code you've extracted operates on four registers (a, b, c, and d) that start at 0 and can hold any integer. However, it seems to make use of only a few instructions:

# cpy x y copies x (either an integer or the value of a register) into register y.
# inc x increases the value of register x by one.
# dec x decreases the value of register x by one.
# jnz x y jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.
# The jnz instruction moves relative to itself: an offset of -1 would continue at the previous instruction, while an offset of 2 would skip over the next instruction.

# For example:

# cpy 41 a
# inc a
# inc a
# dec a
# jnz a 2
# dec a
# The above code would set register a to 41,
# increase its value by 2,
# decrease its value by 1,
# and then skip the last dec a
# (because a is not zero, so the jnz a 2 skips it),
# leaving register a at 42.
# When you move past the last instruction, the program halts.

# After executing the assembunny code in your puzzle input, what value is left in register a?

require 'timeout'

RSpec.configure do |c|
  c.around(:each) do |example|
    Timeout::timeout(180) {
      example.run
    }
  end
end

class Computer
  attr_reader :registers

  def initialize(registers)
    @registers = registers
  end

  def execute(instructions)
    instructions = instructions.lines.map(&:chomp).reject {|l| l.empty?}
    p instructions
    instruction_index = 0
    while instruction_index < instructions.length
      i = instructions[instruction_index]
      i = i.split(' ')
      next_index = instruction_index + 1
      if i[0] == 'cpy'
        target = i[2].to_sym
        if /\d+/ =~ i[1] then
          # p "setting #{target} to #{i[1].to_i}"
          @registers[target] = i[1].to_i
        else
          # p "setting #{target} to value from register #{i[1].to_sym}: #{@registers[i[1].to_sym]}"
          @registers[target] = @registers[i[1].to_sym]
        end
      elsif i[0] == 'inc'
        @registers[i[1].to_sym] += 1
        # p "increment register #{i[1].to_sym} by 1 to #{@registers[i[1].to_sym]}"
      elsif i[0] == 'dec'
        @registers[i[1].to_sym] -= 1
        # p "decrement register #{i[1].to_sym} by 1 to #{@registers[i[1].to_sym]}"
      elsif i[0] == 'jnz'
        reg = 0
        if /\d+/ =~ i[1] then
          reg = i[1].to_i
          p "jump register is a number with value #{reg}"
        else
          reg = @registers[i[1].to_sym]
          p "at #{instruction_index}: jump register is #{i[1].to_sym} with value #{reg}"
        end

        if reg != 0 then
          next_index = instruction_index + i[2].to_i
        end
      end
      # p "at instruction #{instruction_index} registers hold #{@registers}"
      instruction_index = next_index
    end

  end
end

describe "day 12 part one" do
  it "can execute the example input" do
    computer = Computer.new({
      a: 0,
      b: 0,
      c: 0,
      d: 0
      })
    computer.execute(%{
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a})
    expect(computer.registers[:a]).to eq 42
  end

#     it "can do first nine steps of the puzzle input" do
#         computer = Computer.new({
#       a: 0,
#       b: 0,
#       c: 0,
#       d: 0
#       })
#     computer.execute(%{
# cpy 1 a
# cpy 1 b
# cpy 26 d
# jnz c 2
# jnz 1 5
# cpy 7 c
# inc d
# dec c
# jnz c -2
# cpy a c
# inc a
# dec b
# jnz b -2
# cpy c b
# dec d
# jnz d -6})

#     expect(computer.registers[:a]).to eq 26
#     expect(computer.registers[:b]).to eq 1
#     expect(computer.registers[:c]).to eq 1
#     expect(computer.registers[:d]).to eq 0
#   end

  it "can execute the puzzle input" do
    computer = Computer.new({
      a: 0,
      b: 0,
      c: 0,
      d: 0
      })
    computer.execute(%{cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 18 c
cpy 11 d
inc a
dec d
jnz d -2
dec c
jnz c -5})
    p "register a contains #{computer.registers[:a]}"
  end

    it "can execute the puzzle input for part two" do
    computer = Computer.new({
      a: 0,
      b: 0,
      c: 1,
      d: 0
      })
    computer.execute(%{cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 18 c
cpy 11 d
inc a
dec d
jnz d -2
dec c
jnz c -5})
    p "register a contains #{computer.registers[:a]}"
  end
end









