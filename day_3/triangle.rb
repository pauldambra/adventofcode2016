module Triangle
  module_function

  def chunk_columns(s)
    s = s.map(&:chomp).map(&:split).select { |l| l.length == 3 }
    a = s.map { |e| e[0].to_i }
    b = s.map { |e| e[1].to_i }
    c = s.map { |e| e[2].to_i }
    a.concat(b).concat(c).each_slice(3).to_a
  end

  def ensure_array(x)
    if (x.is_a? String) then
      x = x
        .strip
        .split(' ')
        .map { |e| e.to_i  }
    end
    x
  end

  def isPossible?(description)
    sides = ensure_array description
      
    a = sides[0] 
    b = sides[1] 
    c = sides[2]

    a+b>c && b+c>a && a+c>b
  end
end