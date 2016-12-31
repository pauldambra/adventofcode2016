require_relative('../map.rb')

describe "map coordinates" do
      it "can parse a row" do
      row_map = Map.parse(
        %{
###########
#.........#
###########
}
        )
      expect(row_map.pretty_print).to eq(%{###########
#.........#
###########})

      expect(row_map.map[1][0,1]).to eq(['#'])
      expect(row_map.map[1][1,1]).to eq(['.'])
      expect(row_map.map[1][2,1]).to eq(['.'])
      expect(row_map.map[1][3,1]).to eq(['.'])
      expect(row_map.map[1][4,1]).to eq(['.'])
      expect(row_map.map[1][5,1]).to eq(['.'])
      expect(row_map.map[1][6,1]).to eq(['.'])
      expect(row_map.map[1][7,1]).to eq(['.'])
      expect(row_map.map[1][8,1]).to eq(['.'])
      expect(row_map.map[1][9,1]).to eq(['.'])
      expect(row_map.map[1][10,1]).to eq(['#'])
    end
end