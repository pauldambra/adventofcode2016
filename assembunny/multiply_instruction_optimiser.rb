

      # 'cpy b c', # => <-- here
      # 'inc a',
      # 'dec c',
      # 'jnz c -2',
      # 'dec d',
      # 'jnz d -5',# => <-- to here === a = b * d

class MultiplyInstructionOptimiser
  def self.optimise(instructions)
    possible_mult_start = -1
    mult_left = ''
    mult_counter_one = ''
    mult_counter_two = ''
    mult_target = ''

    instructions.each_with_index do |instruction, idx|
      if instruction.start_with? 'cpy'
          possible_mult_start = idx

          split_copy_instruction = instruction.split(' ')

          mult_left = split_copy_instruction[1]
          mult_counter_one = split_copy_instruction[2]

          next
      end

      if idx == possible_mult_start + 1
        if instruction.start_with? 'inc'
          mult_target = instruction.split(' ')[1]
          next
        else
          possible_mult_start = -1
          next
        end
      end

      if idx == possible_mult_start + 2
        if instruction == "dec #{mult_counter_one}"
          next
        else
          possible_mult_start = -1
          next
        end
      end

      if idx == possible_mult_start + 3
        if instruction == "jnz #{mult_counter_one} -2"
          next
        else
          possible_mult_start = -1
          next
        end
      end

      if idx == possible_mult_start + 4
        if instruction.start_with? 'dec'
          mult_counter_two = instruction.split(' ')[1]
          next
        else
          possible_mult_start = -1
          next
        end
      end

      if idx == possible_mult_start + 5

        if instruction == "jnz #{mult_counter_two} -5"
          instructions[possible_mult_start] = "mult #{mult_left} #{mult_counter_two} #{mult_target}"
          instructions[possible_mult_start + 1] = "cpy 0 #{mult_counter_one}"
          instructions[possible_mult_start + 2] = "cpy 0 #{mult_counter_two}"
          instructions[possible_mult_start + 3] = "noop"
          instructions[possible_mult_start + 4] = "noop"
          instructions[possible_mult_start + 5] = "noop"
          possible_mult_start = -1
        else
          possible_mult_start = -1
        end
      end
    end
  end
end