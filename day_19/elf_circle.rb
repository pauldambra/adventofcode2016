class ElfCircle
  attr_reader :elves

  def initialize(elves)
    @elves = elves
  end

  def self.create_a_circle_of_n_elves(n)
    elves = (1..n).map do |i|
      Elf.new(1, i)
    end
    elves.each_with_index do |e, i|
      e.next_elf = elves[i + 1]
    end
    elves.last.next_elf = elves.first
    ElfCircle.new(elves)
  end

  def play
    elf = @elves[0]

    loop do
      if elf == elf.next_elf
        p "#{elf.number} has all the presents!"
        break
      end

      if elf.presents == 0
        raise Exception, "how did we get to an elf with no presents?"
      else
        elf.take_presents
      end

      elf = elf.next_elf
    end
  end
end

class ElfCirclePartTwo
  attr_reader :elves
  attr_reader :winning_elf

  def initialize(elves)
    @elves = elves
    @is_even = @elves.length % 2 == 0
  end

  def self.create_a_circle_of_n_elves(n)
    elves = (1..n).map do |i|
      ElfPartTwo.new(i)
    end
    elves.each_with_index do |e, i|
      e.previous_elf = elves[i - 1]
      e.next_elf = elves[i + 1]
    end
    elves.last.next_elf = elves.first
    elves.first.previous_elf = elves.last

    halfway = (elves.length / 2).floor
    elves.first.target_elf = elves[halfway]
    
    ElfCirclePartTwo.new(elves)
  end

  def play
    elf = @elves.first

    loop do
      p "current elf #{elf.number}"

      if elf == elf.next_elf
        p "#{elf.number} has all the presents!"
        @winning_elf = elf
        break
      end

      target_elf = elf.target_elf
      p "target elf #{target_elf.number}"

      elf.presents += target_elf.presents

      target_elf.next_elf.previous_elf = target_elf.previous_elf
      target_elf.previous_elf.next_elf = target_elf.next_elf

      # if the list is even in length before deleting the used up elf
      # move along two elves otherwise move one
      if @is_even
        elf.next_elf.target_elf = target_elf.next_elf
        p "elf list is even moved target for elf #{elf.next_elf.number} to #{elf.next_elf.target_elf.number}"
      else
        elf.next_elf.target_elf = target_elf.next_elf.next_elf
        p "elf list is odd moved target for elf #{elf.next_elf.number} to #{elf.next_elf.target_elf.number}"
      end

      @is_even = !@is_even #because we always delete one at a time

      elf = elf.next_elf
    end
    
  end

end
