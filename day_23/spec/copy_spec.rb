require_relative('../../assembunny/copy_instruction.rb')

# cpy x y copies x (either an integer or the value of a register)
# into register y.
describe "copy instruction" do
  it "does nothing when invalid" do
    registers = {a: 0, b: 0}
    CopyInstruction.execute('cpy 1 2'.split(' '), registers)
    expect(registers).to eq({a: 0, b: 0})
  end

  it "can copy register value into a register" do
    registers = {a: 2, b: 0}
    CopyInstruction.execute('cpy a b'.split(' '), registers)
    expect(registers).to eq({a: 2, b: 2})
  end

  it "can copy numeric value into a register" do
    registers = {a: 2, b: 0}
    CopyInstruction.execute('cpy 19 b'.split(' '), registers)
    expect(registers).to eq({a: 2, b: 19})
  end
end