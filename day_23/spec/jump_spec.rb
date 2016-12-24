
require_relative('../jumping_instruction.rb')

describe "jumping" do
  context "x is 0" do
    it "does not change next index" do
      ni = JumpInstruction.execute("jnz 0 1".split(' '), {}, 4, 12)
      expect(ni).to eq 12
    end
  end

  context "x is not 0" do
    it "jumps by value if y is a positive number" do
      ni = JumpInstruction.execute("jnz 1 100".split(' '), {}, 4, 5)
      expect(ni).to eq 104
    end

    it "jumps by value if y is a negative number" do
      ni = JumpInstruction.execute("jnz 1 -2".split(' '), {}, 4, 5)
      expect(ni).to eq 2
    end

    it "jumps by register value if y is a register" do
      ni = JumpInstruction.execute("jnz 1 x".split(' '), {x: 26}, 4, 5)
      expect(ni).to eq 30
    end
  end
  
  it "it is invalid" do
    ni = JumpInstruction.execute("jnz 1 x".split(' '), {a: 26}, 4, 5)
    expect(ni).to eq 5
  end
end