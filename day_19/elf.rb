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

    @next_elf = @next_elf.next_elf
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