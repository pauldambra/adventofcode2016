
class AddInstructionOptimiser
  def self.optimise(instructions)
    possible_add_start = -1
    instructions.each_with_index do |instruction, idx|

      if instruction.start_with? 'inc'
          possible_add_start = idx
          next
      end

      if idx == possible_add_start + 1
        if instruction.start_with? 'dec'
          next
        elsif instruction.start_with? 'inc'
          possible_add_start = idx
          next
        else
          possible_add_start = -1
          next
        end
      end

      if idx == possible_add_start + 2
        if instruction.start_with?('jnz') && instruction.split(' ')[2] == '-2'
          dec_counter = instructions[possible_add_start + 1].split(' ')[1]
          current = instructions[possible_add_start].split(' ')
          new_instruction = "add #{dec_counter} #{current[1]}"
          instructions[possible_add_start] = new_instruction
          instructions[possible_add_start + 1] = "cpy 0 #{dec_counter}"
          instructions[possible_add_start + 2] = "noop"
          possible_add_start = -1
        else
          possible_add_start = -1
        end
      end
    end
  end
end