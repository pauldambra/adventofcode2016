class InvalidRegisterKey < StandardError; end

class JumpInstruction
  def self.execute(i, registers, instruction_index, next_index)
    # jnz x y jumps to an instruction y away 
    # (positive means forward; negative means backward), 
    # but only if x is not zero.
    x = i[1]
    y = i[2]

    reg = get_number_or_register(x, registers)
    
    return next_index if reg == 0
  
    jump_value = get_number_or_register(y, registers)
    next_index = instruction_index + jump_value

  rescue InvalidRegisterKey
    next_index
  end

  private

  def self.get_number_or_register(value, registers)
    if /\d+/ =~ value then
      result = value.to_i
    else
      target_register_key = value.to_sym
      if registers.include? target_register_key
        result = registers[target_register_key]
      else
        raise InvalidRegisterKey
      end
    end
    result
  end
end