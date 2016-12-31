
require_relative('../../assembunny/multiply_instruction_optimiser.rb')

describe "day 25 - multiply optimisation" do
  it "can multiply b * d into a without optimisation" do
    
    instructions = MultiplyInstructionOptimiser.optimise([
     'cpy a d',
     'cpy 4 c',
     'cpy 643 b',# <----+
     'inc d',#     <--+ |
     'dec b',#        | |
     'jnz b -2',#   --+ |
     'dec c',#          |
     'jnz c -5',#   ----+
    ])
    expect(instructions).to eq [
      "cpy a d", 
      "cpy 4 c", 
      "mult 643 c d", 
      "cpy 0 b", 
      "cpy 0 c", 
      "noop", 
      "noop", 
      "noop"
    ]
  end
end