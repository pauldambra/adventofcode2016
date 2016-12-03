require_relative('../santa_saver')

describe "taking simple journies" do
  let(:santa_saver) {santa_saver = SantaSaver.new}

    it "can just go nowhere" do
      santa_saver.grid_walker.walk('R0, R0, R0')

      expect(santa_saver.grid_walker.blocks_travelled).to eq(0)
    end

    it "can just go in a loop" do
      santa_saver.grid_walker.walk('R1, R1, R1, R1')

      expect(santa_saver.grid_walker.blocks_travelled).to eq(0)
    end

    it "can go more than ten in one go" do
      santa_saver.grid_walker.walk('R11')

      expect(santa_saver.grid_walker.blocks_travelled).to eq(11)
    end
end