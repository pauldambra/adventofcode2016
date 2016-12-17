

describe "the simulator" do
  xit "can deal with multiples" do
    simulaton_result = SculptureSimulator.simulate([
      Disk.new(0, 17, 1),
      Disk.new(1, 7, 0),
      Disk.new(2, 19, 2),
      Disk.new(3, 5, 0)
      ])

    expect(Disk.button_multiple).to eq 2
  end
end