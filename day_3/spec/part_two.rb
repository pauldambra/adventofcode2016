require_relative('../triangle.rb')
require_relative('../../common/array.rb')

example = %{
101 301 501
102 302 502
103 303 503
201 401 601
202 402 602
203 403 603
}

describe "day 3 - part two - counting impossible triangles by column" do
  it "can chunk by column" do
    chunks = example.lines.chunk_columns_of_numbers_into(3)
    expect(chunks.count).to eq(6)
  end

  it "can count possible triangles in puzzle input by column" do
    all_lines = File.readlines(__dir__ + '/puzzle_input.txt')

    possible_triangle_count = all_lines.chunk_columns_of_numbers_into(3)
      .select { |l| Triangle.isPossible? l }
      .count
    p "counted #{possible_triangle_count} possible triangles"
  end
end
