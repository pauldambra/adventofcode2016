
class CopyInstruction
  def self.execute(i, registers)
    target_register_key = i[2].to_sym
    
    return unless registers.include? target_register_key

    if /\d+/ =~ i[1] then
       new_value = i[1].to_i
    else
      new_value = registers[i[1].to_sym]
    end

    registers[target_register_key] = new_value
  end
end