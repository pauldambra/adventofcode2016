
describe "the rotation by index" do
  it "works for all the cases" do
    expect(RotateBasedOnLetterPosition.scramble_index(0)).to eq -1
    expect(RotateBasedOnLetterPosition.scramble_index(1)).to eq -2
    expect(RotateBasedOnLetterPosition.scramble_index(2)).to eq -3
    expect(RotateBasedOnLetterPosition.scramble_index(3)).to eq -4
    expect(RotateBasedOnLetterPosition.scramble_index(4)).to eq -6
    expect(RotateBasedOnLetterPosition.scramble_index(5)).to eq -7
    expect(RotateBasedOnLetterPosition.scramble_index(6)).to eq -8
    expect(RotateBasedOnLetterPosition.scramble_index(7)).to eq -9
  end

  it "calculates the starting index for every ending index" do
    expect(RotateBasedOnLetterPosition.five_char_index_map).to eq [
      2,4,0,3,1
    ]

    expect(RotateBasedOnLetterPosition.eight_char_index_map).to eq [
      7, 0, 4, 1, 5, 2, 6, 3
    ]
  end
end