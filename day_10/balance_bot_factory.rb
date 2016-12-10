require_relative('./target.rb')

class BalanceBotFactory
  def initialize(instructions)
    @bots = []
    @output_bins = []

    process instructions.split("\n")
                        .map(&:chomp)
                        .map(&:strip)
                        .reject(&:empty?)
  end

  def bot_that_compares(l, r)
    l = l.split('-')[1].to_i
    r = r.split('-')[1].to_i
    needle = [l, r].sort
    matches = @bots.select { |b| b.chips == needle }
    matches[0].number
  end

  def output(index)
    @output_bins[index]
  end

  private

  def process(instructions)
    set_chip_movements(instructions.reject { |i| i.start_with? 'value'})
    set_initial_positions(instructions.select { |i| i.start_with? 'value'})
  end

  def set_initial_positions(init_instructions)
    init_instructions.each do |ins|
      value, bot_number = ins.split 'goes to'
      value = number_at_end(value)
      bot_number = number_at_end(bot_number)

      bot = ensure_bot_is_present(bot_number)
      bot.give(value)
    end
  end

  def ensure_bot_is_present(number)
    bot = @bots[number] || BalanceBot.new(number)
    @bots[number] = bot
    bot
  end

  def ensure_output_bin_is_present(number)
    output_bin = @output_bins[number] || OutputBin.new(number)
    @output_bins[number] = output_bin
    output_bin
  end

  def set_chip_movements(instructions)
    instructions.each do |ins|
      set_initial_positions(instructions.select { |i| i.start_with? 'value'})
      bot_number, destinations = ins.split(' gives ')
      bot_number = number_at_end(bot_number)
      
      bot = ensure_bot_is_present(bot_number)

      destinations = destinations.split(' and ')
      set_low_chip_target(bot, destinations[0])
      set_high_chip_target(bot, destinations[1])   
    end
  end

  def set_low_chip_target(bot, instruction)
    target = get_target(instruction)
    bot.give_low_to target
  end

  def set_high_chip_target(bot, instruction)
    target = get_target(instruction)
    bot.give_high_to target
  end

  def get_target(instruction)
    instruction = instruction.split(' to ')[1]
    number = number_at_end(instruction)

    if instruction.start_with? 'bot'
      return ensure_bot_is_present(number)
    else 
      return ensure_output_bin_is_present(number)
    end
  end

  def number_at_end(s)
    /(\d+$)/.match(s.strip).captures[0].to_i
  end
end