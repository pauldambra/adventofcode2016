
require_relative('../../assembunny/add_instruction_optimiser.rb')


describe "optimizations exist" do
  it "the computer can collapse to an addition" do
    new_instructions = AddInstructionOptimiser.optimise([
      'inc b',
      'inc a',
      'dec c',
      'jnz c -2',
      'inc b'
    ])
    
    expect(new_instructions).to eq [
      'inc b',
      'add c a',
      'cpy 0 c',
      'noop',
      'inc b'
    ]
  end
  
  it "uses the jump count to confirm" do
    new_instructions = AddInstructionOptimiser.optimise([
      'inc b',
      'inc a',
      'dec c',
      'jnz c -4',
      'inc b'
    ])
    
    expect(new_instructions).to eq [
      'inc b',
      'inc a',
      'dec c',
      'jnz c -4',
      'inc b'
    ]
  end

end