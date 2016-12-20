require_relative('../elf_circle.rb')
require_relative('../elf.rb')

# --- Day 19: An Elephant Named Joseph ---

# The Elves contact you over a highly secure emergency channel.
# Back at the North Pole, the Elves are busy misunderstanding White
# Elephant parties.

# Each Elf brings a present. They all sit in a circle, numbered
# starting with position 1. Then, starting with the first Elf, they
# take turns stealing all the presents from the Elf to their left.
# An Elf with no presents is removed from the circle and does not take
# turns.

# For example, with five Elves (numbered 1 to 5):

#   1
# 5   2
#  4 3
# Elf 1 takes Elf 2's present.
# Elf 2 has no presents and is skipped.
# Elf 3 takes Elf 4's present.
# Elf 4 has no presents and is also skipped.
# Elf 5 takes Elf 1's two presents.
# Neither Elf 1 nor Elf 2 have any presents, so both are skipped.
# Elf 3 takes Elf 5's three presents.
# So, with five Elves, the Elf that sits starting in position 3 gets
# all the presents.

# With the number of Elves given in your puzzle input, which Elf gets
# all the presents?

# Your puzzle input is 3012210.

describe "day nineteen - part one" do
  describe "an elf" do
    it "can have one present" do
      e = Elf.new(1, 1)
      expect(e.presents).to eq 1
    end

    it "can take one present from another elf" do
      two = Elf.new(1, 2)
      one = Elf.new(1, 1)
      two.next_elf = one
      one.next_elf = two
      one.take_presents
      
      expect(two.presents).to eq 0
      expect(one.presents).to eq 2
    end

    it "can update the next elf pointer as it takes presents" do
      three = Elf.new(1, 3)
      two = Elf.new(1, 2)
      one = Elf.new(1, 1)
      one.next_elf = two
      two.next_elf = three
      three.next_elf = one

      one.take_presents

      expect(one.next_elf).to be three
    end
  end

  describe "an elf circle" do
    it "can have a number of elves" do
      c = ElfCircle.create_a_circle_of_n_elves(5)
      expect(c.elves.length).to eq 5
    end

    it "can pass presents around the circle" do
      c = ElfCircle.create_a_circle_of_n_elves(3)
      c.play
      expect(c.elves.map { |e| e.presents }).to eq [0,0,3]
    end
  end

  it "can solve the example input" do
    c = ElfCircle.create_a_circle_of_n_elves(5)
    c.play
    expect(c.elves.map { |e| e.presents }).to eq [0,0,5,0,0]
  end

  xit "can solve the puzzle input" do
    c = ElfCircle.create_a_circle_of_n_elves(3012210)
    c.play
  end
end