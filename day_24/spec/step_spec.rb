
describe "steps" do
  it "can compare steps" do
    step_one = Step.new([0,0])
    step_one.passage_content = '.'
    step_one.numbers_still_to_reach = [0,1,2,3,4]

    step_two = Step.new([0,0])
    step_two.passage_content = '.'
    step_two.numbers_still_to_reach = [0,1,2,3,4]

    expect(step_one).to eq(step_two)
  end

  it "can tell different steps when you get back to them" do
    step_one = Step.new([0,0])
    step_one.passage_content = '.'
    step_one.numbers_still_to_reach = [0,1,2,3,4]

    step_two = Step.new([0,0])
    step_two.passage_content = '.'
    step_two.numbers_still_to_reach = [1,2,3,4]

    expect(step_one).not_to eq(step_two)
  end

  it "can clone steps" do
    step_one = Step.new([0,0])
    step_one.passage_content = '.'
    step_one.numbers_still_to_reach = [0,1,2,3,4]

    step_two = step_one.clone

    expect(step_two).to eq step_one
    expect(step_two).not_to be step_one
  end
end