
require_relative('../../assembunny/multiply_instruction_optimiser.rb')

describe "multiply optimisation" do
  it "can multiply b * d into a without optimisation" do
    
    instructions = MultiplyInstructionOptimiser.optimise([
      'inc c',
      'cpy b c', # => <-- here
      'inc a',
      'dec c',
      'jnz c -2',
      'dec d',
      'jnz d -5',# => <-- to here === a = b * d
      'inc c'
    ])
    expect(instructions).to eq [
      'inc c',
      'mult b d a',
      'cpy 0 c',
      'cpy 0 d',
      'noop',
      'noop',
      'noop',
      'inc c'
    ]
  end
end