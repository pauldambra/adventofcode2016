require_relative('../map.rb')

describe "the path" do
  it "cannot add the same step twice" do
    p = Path.new([0,1,2,3,4])
    step_one = Step.new([0,0])
    step_one.passage_content = '.'
    step_one.numbers_still_to_reach = [0,1,2,3,4]

    step_two = Step.new([0,0])
    step_two.passage_content = '.'
    step_two.numbers_still_to_reach = [0,1,2,3,4]

    p.add_step(step_one)

    expect { p.add_step(step_two) }.to raise_error RevisitingPath

    expect(p.steps.length).to eq 1
  end
end