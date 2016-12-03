require_relative('../triangle.rb')

example = %{
101 301 501
102 302 502
103 303 503
201 401 601
202 402 602
203 403 603
}

describe "part two - counting impossible triangles by column" do
  it "can chunk by column" do
    chunks = Triangle.chunk_columns(example.lines)
    expect(chunks.count).to eq(6)
  end

  it "can count possible triangles in puzzle input by column" do
    all_lines = File.readlines(__dir__ + '/puzzle_input.txt')

    possible_triangle_count = Triangle.chunk_columns(all_lines)
      .select { |l| Triangle.isPossible? l }
      .count
    p "counted #{possible_triangle_count} possible triangles"
  end
end