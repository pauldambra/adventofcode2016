require_relative('../simulator.rb')

describe "the simulator" do
  context "rotating disks" do
    it "can rotate less than the length" do
      d = [0,1,2,3,4,5]
      SculptureSimulator.disk_rotatations!(d, 3)
      expect(d).to eq [3,4,5,0,1,2]
    end

    it "can rotate more than the length" do
      d = [0,1,2,3,4,5,6,7,8]
      expected = [7,8,0,1,2,3,4,5,6]

      SculptureSimulator.disk_rotatations!(d, 25)
      expect(d).to eq expected

      d = [0,1,2,3,4,5,6,7,8]
      SculptureSimulator.disk_rotatations!(d, 7)
      expect(d).to eq expected
    end
  end

  it "can simulate a failure" do
    expect {
      SculptureSimulator.simulate_at_tick([
        {number_of_positions: 17, starting_position: 1}
      ], 2043) # < much too high!
    }.to raise_error StandardError
  end

  it "can simulate a single disk" do
    simulation_result = SculptureSimulator.simulate([
      {number_of_positions: 17, starting_position: 1}
    ])
    expect(simulation_result).to be 15

    SculptureSimulator.simulate_at_tick([
      {number_of_positions: 17, starting_position: 1}
    ], 15)
  end

  it "can simulate two simple disks" do
    simulation_result = SculptureSimulator.simulate([
      {number_of_positions: 5, starting_position: 4},
      {number_of_positions: 2, starting_position: 1}
    ])
    expect(simulation_result).to be 5

    SculptureSimulator.simulate_at_tick([
      {number_of_positions: 5, starting_position: 4},
      {number_of_positions: 2, starting_position: 1}
    ], 5)
  end
end