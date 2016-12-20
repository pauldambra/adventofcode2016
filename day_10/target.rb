class Target
  attr_reader :number
  attr_reader :chips
  
  def initialize(number)
    @number = number
    @chips = []
  end

  def give(chip)
    # p "#{self.class} #{@number} received chip #{chip}"

    @chips.push chip
    @chips = @chips.sort
  end
end


class OutputBin < Target

end

class BalanceBot < Target
  def give(chip)
    super(chip)

    if @chips.length == 2 
      @low_target.give @chips[0]
      @high_target.give @chips[1]
    end
  end

  def give_low_to(target)
    @low_target = target
  end

  def give_high_to(target)
    @high_target = target
  end
end