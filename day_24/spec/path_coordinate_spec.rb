require_relative('../map.rb')

describe "path coordinates" do
  it "can walk along a row" do
    row_map = Map.parse(
        %{
###########
#0.......1#
###########
})

    path = row_map.coord_to_step_on_path([1,1], Path.new([0,1]))

    one = row_map.next_step_from([path])
    expect(one.first.numbers_still_to_reach).to eq [1]
    expect(one.first.steps.map { |s| s.coordinate }).to match_array [
      [1,1], [2,1]
    ]

    two = row_map.next_step_from(one)
    expect(two.all? {|p| p.numbers_still_to_reach == [1]}).to eq true
    
two.each {|t| p t.steps.inspect }

    expect(two[0].steps.map { |s| s.coordinate }).to match_array [
      [1,1], [2,1], [3,1]
    ]

    three = row_map.next_step_from(two)
    expect(two.all? {|p| p.numbers_still_to_reach == [1]}).to eq true
    expect(three[0].steps.map { |s| s.coordinate }).to match_array [
      [1,1], [2,1], [3,1], [4,1]
    ]

    four = row_map.next_step_from(three)
    five = row_map.next_step_from(four)
    six = row_map.next_step_from(five)
    seven = row_map.next_step_from(six)
    eight = row_map.next_step_from(seven)

    expect(eight[0].numbers_still_to_reach).to be_empty
    expect(eight[0].steps.map { |s| s.coordinate }).to match_array [
      [1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [8,1], [9,1]
    ]
  end
end