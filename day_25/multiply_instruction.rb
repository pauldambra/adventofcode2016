class UnknownRegister < StandardError; end

class MultiplyInstruction
  def self.execute(i, registers)
    
    target_register_key = i[3].to_sym
    return unless registers.include? target_register_key

    left = number_or_register(i[1], registers)
    right = number_or_register(i[2], registers)
    target = registers[target_register_key]

    registers[target_register_key] = target + (left * right)
  rescue UnknownRegister
    #swallow
  end

 private

 def self.number_or_register(i, registers)
    if /\d+/ =~ i then
        new_value = i.to_i
    else
        register_key = i.to_sym
        raise UnknownRegister unless registers.include? register_key
        new_value = registers[register_key]
    end
 end
end