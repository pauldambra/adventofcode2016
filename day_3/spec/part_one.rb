require_relative('../triangle.rb')

describe "part one - counting impossible triangles" do
  it "identifies possible triangles" do
    expect(Triangle.isPossible?("5  10       7")).to be(true)
    expect(Triangle.isPossible?("5  10   15")).to be(false)
  end

  it "identifies example impossible triangle" do
    expect(Triangle.isPossible?("5 10 25")).to be(false)
  end

  it "can count possible triangles in puzzle input" do
    all_lines = File.readlines(__dir__ + '/puzzle_input.txt')
    possible_triangle_count = all_lines
      .select { |l| Triangle.isPossible? l }
      .count
    p "counted #{possible_triangle_count} possible triangles"
  end
end