
class Array
  def chunk_columns_of_numbers_into(n)
    s = self.map(&:chomp).map(&:split).select { |l| l.length > 0 }
    a = s.map { |e| e[0].to_i }
    b = s.map { |e| e[1].to_i }
    c = s.map { |e| e[2].to_i }
    a.concat(b).concat(c).each_slice(n).to_a
  end

  def chunk_columns_of_characters_by(m, n)
    s = self.map(&:chomp).map { |str| str.chars }.select { |l| l.length > 0 }

    a = []
    for i in 0..(m - 1)
       a.concat(s.map { |e| e[i] })
    end

    a.each_slice(n).to_a
  end
end
