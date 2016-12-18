class String
  def dragon_checksum_for_length(disk_length)
    data = self
    loop do
      data = data.pre_dragon
      break if data.length >= disk_length
    end
    data = data.slice(0,disk_length)
    data.dragon_sum
  end

  def pre_dragon
    a = self
    b = self.clone.reverse
                  .chars
                  .map { |e| e == "1" ? "0" : "1" }
                  .join('')
    "#{a}0#{b}"
  end

  def dragon_sum
    checksum = self
    loop do
      checksum = checksum.chars
                     .each_slice(2)
                     .map { |s| s.first == s.last ? "1" : "0" }
                     .join('')
      break if checksum.length % 2 != 0
    end
    checksum
  end
end