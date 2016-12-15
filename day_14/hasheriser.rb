require 'digest'

class Hasheriser
  def make(salt, index)
    get_hash("#{salt}#{index}")
  end

  def get_hash(s)
    Digest::MD5.hexdigest(s)
  end
end

class StretchingHasheriser
  def initialize
    @hasher = Hasheriser.new
  end

  def make(salt, index)
    h = "#{salt}#{index}"
    for i in 0..2016
      h = @hasher.get_hash(h)
    end
    h
  end
end