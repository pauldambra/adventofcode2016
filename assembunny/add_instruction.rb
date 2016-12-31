
#add a register to a register
class AddInstruction
  def self.execute(i, registers)
    from_register_key = i[1].to_sym
    to_register_key = i[2].to_sym

    return unless registers.include? from_register_key
    return unless registers.include? to_register_key

    from = registers[from_register_key]
    to = registers[to_register_key]
    registers[to_register_key] = from + to
  end
end
