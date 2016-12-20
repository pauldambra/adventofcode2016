class Elf
  attr_accessor :presents
  attr_reader :number
  attr_accessor :next_elf

  def initialize(presents, number)
    @presents = presents
    @number = number
  end

  def take_presents
    raise ArgumentError, "cannot take presents if elf does not exist" if @next_elf == nil

    new_present_count = @next_elf.presents + presents
    @next_elf.presents = 0
    @presents = new_present_count

    p "elf #{@number} takes presents from elf #{@next_elf.number}."
    p "leaving it with #{@next_elf.presents} and itself with #{presents}"

    @next_elf = @next_elf.next_elf

    p "next elf is now #{@next_elf.number}"
  end
end

class ElfPartTwo
  attr_accessor :presents
  attr_reader :number
  attr_accessor :next_elf
  attr_accessor :target_elf
  attr_accessor :previous_elf

  def initialize(number)
    @presents = 1
    @number = number
  end
end