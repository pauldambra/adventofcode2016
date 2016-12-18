class Vault
  attr_reader :seed
  attr_reader :position
  attr_reader :path

  @@dirs_for_seed ||= {
    up: 'U',
    down: 'D',
    left: 'L',
    right: 'R'
  }

  def initialize(seed, path, position)
    @seed = seed
    @path = path
    @position = position
  end

  def next_options
    dirs = VaultCracker.directions("#{@seed}#{@path}")

    nexts = Hash.new
    nexts[:left] = [@position[0]-1, @position[1]] if dirs[:left] == :open 
    nexts[:right] = [@position[0]+1, @position[1]] if dirs[:right] == :open
    nexts[:up] = [@position[0], @position[1]-1] if dirs[:up] == :open
    nexts[:down] = [@position[0], @position[1]+1] if dirs[:down] == :open
    
    nexts = nexts.reject { |k,v| v[0] < 0 || v[0] > 3 }
                 .reject { |k,v| v[1] < 0 || v[1] > 3 }

    nexts.map { |k,v| Vault.new @seed, "#{@path}#{@@dirs_for_seed[k]}", v}
  end

  def ==(other)
    return false if other == nil
    @seed == other.seed && @path == other.path  && @position == other.position
  end
end