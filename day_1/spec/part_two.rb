require_relative('../santa_saver')

main_puzzle_input = 'L2, L3, L3, L4, R1, R2, L3, R3, R3, L1, L3, R2, R3, L3, R4, R3, R3, L1, L4, R4, L2, R5, R1, L5, R1, R3, L5, R2, L2, R2, R1, L1, L3, L3, R4, R5, R4, L1, L189, L2, R2, L5, R5, R45, L3, R4, R77, L1, R1, R194, R2, L5, L3, L2, L1, R5, L3, L3, L5, L5, L5, R2, L1, L2, L3, R2, R5, R4, L2, R3, R5, L2, L2, R3, L3, L2, L1, L3, R5, R4, R3, R2, L1, R2, L5, R4, L5, L4, R4, L2, R5, L3, L2, R4, L1, L2, R2, R3, L2, L5, R1, R1, R3, R4, R1, R2, R4, R5, L3, L5, L3, L3, R5, R4, R1, L3, R1, L3, R3, R3, R3, L1, R3, R4, L5, L3, L1, L5, L4, R4, R1, L4, R3, R3, R5, R4, R3, R3, L1, L2, R1, L4, L4, L3, L4, L3, L5, R2, R4, L2'

describe "part 2 - Easter Bunny HQ is at the first location you visit twice" do
  let(:santa_saver) {santa_saver = SantaSaver.new}

  it "when instructions are R8, R4, R4, R8 Easter Bunny HQ is 4 east"  do
    santa_saver.grid_walker.walk('R8, R4, R4, R8')

    expect(santa_saver.grid_walker.easter_bunny_location).to eq(4)
  end

  it 'can be used to solve the puzzle' do
    santa_saver.grid_walker.walk(main_puzzle_input)

    p "actual input places you #{santa_saver.grid_walker.easter_bunny_location} blocks away"
  end
end