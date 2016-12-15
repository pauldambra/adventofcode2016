  
describe "why does it not work :(" do
  it "can detect only the first three repeated characters"  do
    one = HashChecker.has_three_repeated_characters('12345aaa567bbb456')
    expect(one).to eq 'a'

    two = HashChecker.has_three_repeated_characters('12345567bb456')
    expect(two).to eq nil
  end

  it "can generate expected hashes" do
    expect(Hasheriser.new.make('abc', 18)).to eq '0034e0923cc38887a57bd7b1d4f953df'
  end

  it "can detect canidates in the example input" do
    h = Hasheriser.new.make('abc', '18')
    first = HashChecker.has_three_repeated_characters(h)
    expect(first).to eq '8'
  end

  it "can detect the five repeated characters"  do
    one = HashChecker.has_five_repeated('12345aaa567bbb456', 'a')
    expect(one).to eq nil

    two = HashChecker.has_five_repeated('12345567bb456', '5')
    expect(two).to eq nil

    three = HashChecker.has_five_repeated('12345567bbbbb456', 'b')
    expect(three[1]).to eq 'b'
  end  

  it "can promote candidates when they have not expired" do
    promoter = CandidatePromoter.new(10)
    valid_keys = promoter.check([
      {
        index: 0, 
        character: 'a', 
        hash: '123aaa345' # will not validate
      },
      {
        index: 4, 
        character: 'd', 
        hash: '123ddd34bbbbb5' # will not validate
      },
      {
        index: 8, 
        character: 'a', 
        hash: '123aaa34bbb5' # will validate
      }
      ], '123aaaaa34bbbbb5', 12)

    expect(valid_keys).to eq [{
        index: 8, 
        character: 'a', 
        hash: '123aaa34bbb5', # will validate against 123aaaaa34bbbbb5
        expired: false
      }]
  end
end