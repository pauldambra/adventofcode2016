require_relative('../../assembunny/toggle_instruction.rb')

# tgl x toggles the instruction x away (pointing at instructions like jnz does:
# positive means forward; negative means backward):

# For one-argument instructions, inc becomes dec, and all other one-argument
# instructions become inc.
# For two-argument instructions, jnz becomes cpy, and all other
# two-instructions become jnz.
# The arguments of a toggled instruction are not affected.
# If an attempt is made to toggle an instruction outside the program,
# nothing happens.
# If toggling produces an invalid instruction (like cpy 1 2) and an attempt
# is later made to execute that instruction, skip it instead.
# If tgl toggles itself (for example, if a is 0, tgl a would target itself
# and become inc a), the resulting instruction is not executed until the next
# time it is reached.

describe "toggle instruction" do

  context "for one argument target instructions" do

    it "toggles inc to dec" do
      instructions = [
        'instruction 0',
        'instruction 1',
        'inc a'
      ]
      # a: 1 and index 1 = tgl 2
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 1},
        1, 
        instructions
      )

      expect(instructions[2]).to eq('dec a')
    end

    it "toggle dec to inc" do
      instructions = [
        'instruction 0',
        'instruction 1',
        'dec a'
      ]
      # a: 1 and index 1 = tgl 2
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 1},
        1, 
        instructions
      )

      expect(instructions[2]).to eq('inc a')
    end

    it "can toggle itself" do
      instructions = [
        'instruction 0',
        'tgl a',
        'dec a'
      ]
      # a: 0 and index 1 = tgl 1
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 0},
        1, 
        instructions
      )

      expect(instructions[1]).to eq('inc a')
    end
  end

  context "for two argument target instructions" do
    
    it "toggles jnz to cpy" do
      instructions = [
        'instruction 0',
        'instruction 1',
        'jnz 1 a'
      ]
      # a: 1 and index 1 = tgl 2
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 1},
        1, 
        instructions
      )

      expect(instructions[2]).to eq('cpy 1 a')
    end

    it "toggles cpy to jnz" do
      instructions = [
        'instruction 0',
        'instruction 1',
        'cpy 1 a'
      ]
      # a: 1 and index 1 = tgl 2
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 1},
        1, 
        instructions
      )

      expect(instructions[2]).to eq('jnz 1 a')
    end
  end

  context "for targets outside of the program" do
    it "does nothing" do
      instructions = [
        'instruction 0',
        'instruction 1',
        'cpy 1 a'
      ]
      # a: 1 and index 1 = tgl 2
      ToggleInstruction.execute(
        'tgl a'.split(' '), 
        {a: 10},
        1, 
        instructions
      )

      expect(instructions).to eq([
        'instruction 0',
        'instruction 1',
        'cpy 1 a'
      ])
    end
  end
end