
class MultiplyInstruction
  def self.execute(i, registers)
    left_register_key = i[1].to_sym
    right_register_key = i[2].to_sym
    target_register_key = i[3].to_sym

    return unless registers.include? left_register_key
    return unless registers.include? right_register_key
    return unless registers.include? target_register_key

    left = registers[left_register_key]
    right = registers[right_register_key]
    target = registers[target_register_key]
    registers[target_register_key] = target + (left * right)
  end
end