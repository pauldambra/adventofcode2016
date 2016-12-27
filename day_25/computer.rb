
require_relative('./toggle_instruction.rb')
require_relative('./jumping_instruction.rb')
require_relative('./copy_instruction.rb')
require_relative('./add_instruction.rb')
require_relative('./add_instruction_optimiser.rb')
require_relative('./multiply_instruction_optimiser.rb')
require_relative('./multiply_instruction.rb')

class Computer
  attr_reader :registers
  attr_reader :out_signal

  def initialize(registers)
    @registers = registers
    @out_signal = []
  end

  def execute(instructions)
    instructions = MultiplyInstructionOptimiser.optimise(instructions)
    instructions = AddInstructionOptimiser.optimise(instructions)

    found_alternating_signal = false

    instruction_index = 0
    while instruction_index < instructions.length

      found_alternating_signal = is_alternating?(out_signal)

      break unless found_alternating_signal #must be alternating
      break if out_signal.length == 201 #do not run forever

      i = instructions[instruction_index]
      i = i.split(' ')
      next_index = instruction_index + 1
      if i[0] == 'tgl'
        ToggleInstruction.execute(i, @registers, instruction_index, instructions)
      elsif i[0] == 'mult'
        MultiplyInstruction.execute(i, registers)
      elsif i[0] == 'out'
        @out_signal.push(@registers[i[1].to_sym])
      elsif i[0] == 'cpy'
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
        next_index = JumpInstruction.execute(i, @registers, instruction_index, next_index)
      elsif i[0] == 'add'
        AddInstruction.execute(i, @registers)
      end
      # p "at instruction #{instruction_index} registers hold #{@registers}"
      instruction_index = next_index
      # p "instruction_index now #{instruction_index}"
    end

    found_alternating_signal
  end

    def is_alternating?(s)
      return true if s.empty?
      return true if s.length < 2

      evens_are_zeroes = s.select.with_index { |_, i| i.even? }
                                  .all? { |c| c == 0 }
      odds_are_ones = s.select.with_index { |_, i| i.odd? }
                                  .all? { |c| c == 1 }
      evens_are_zeroes && odds_are_ones
    end

  def self.parse(instructions)
    instructions.lines.map(&:chomp).reject {|l| l.empty?}
  end
end