
class ToggleInstruction
  def self.execute(i, registers, instruction_index, instructions)
    index_to_toggle = get_index_to_toggle(instruction_index, registers, i)

    return if index_to_toggle > instructions.length - 1

    unchanged_instruction = instructions[index_to_toggle].split(' ')

    if unchanged_instruction.length == 2
      new_instruction = toggle_one_argument_instruction(unchanged_instruction)
    else
      new_instruction = toggle_two_argument_instruction(unchanged_instruction)
    end

    instructions[index_to_toggle] = new_instruction
  end

  private

  def self.get_index_to_toggle(instruction_index, registers, instruction)
    index_to_jump = registers[instruction[1].to_sym]
    instruction_index + index_to_jump
  end

  def self.toggle_one_argument_instruction(unchanged_instruction)
    new_instruction = unchanged_instruction[0] == 'inc' ? 'dec' : 'inc'
    "#{new_instruction} #{unchanged_instruction[1]}"
  end

  def self.toggle_two_argument_instruction(unchanged_instruction)
    new_instruction = unchanged_instruction[0] == 'jnz' ? 'cpy' : 'jnz'
    "#{new_instruction} #{unchanged_instruction[1]} #{unchanged_instruction[2]}"
  end
end