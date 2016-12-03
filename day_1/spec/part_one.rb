require_relative('../santa_saver')

main_puzzle_input = 'L2, L3, L3, L4, R1, R2, L3, R3, R3, L1, L3, R2, R3, L3, R4, R3, R3, L1, L4, R4, L2, R5, R1, L5, R1, R3, L5, R2, L2, R2, R1, L1, L3, L3, R4, R5, R4, L1, L189, L2, R2, L5, R5, R45, L3, R4, R77, L1, R1, R194, R2, L5, L3, L2, L1, R5, L3, L3, L5, L5, L5, R2, L1, L2, L3, R2, R5, R4, L2, R3, R5, L2, L2, R3, L3, L2, L1, L3, R5, R4, R3, R2, L1, R2, L5, R4, L5, L4, R4, L2, R5, L3, L2, R4, L1, L2, R2, R3, L2, L5, R1, R1, R3, R4, R1, R2, R4, R5, L3, L5, L3, L3, R5, R4, R1, L3, R1, L3, R3, R3, R3, L1, R3, R4, L5, L3, L1, L5, L4, R4, R1, L4, R3, R3, R5, R4, R3, R3, L1, L2, R1, L4, L4, L3, L4, L3, L5, R2, R4, L2'

describe 'the example input provided' do
  let(:santa_saver) {santa_saver = SantaSaver.new}

  it 'Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.'  do
    santa_saver.grid_walker.walk('R2, L3')

    expect(santa_saver.grid_walker.blocks_travelled).to eq(5)
  end

  it 'R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.' do |variable|
    santa_saver.grid_walker.walk('R2, R2, R2')

    expect(santa_saver.grid_walker.blocks_travelled).to eq(2)
  end

  it 'R5, L5, R5, R3 leaves you 12 blocks away.' do
    santa_saver.grid_walker.walk('R5, L5, R5, R3')

    expect(santa_saver.grid_walker.blocks_travelled).to eq(12)
  end

  it 'can be used to solve the puzzle' do
    santa_saver.grid_walker.walk(main_puzzle_input)

    p "actual input places you #{santa_saver.grid_walker.blocks_travelled} blocks away"
  end
end