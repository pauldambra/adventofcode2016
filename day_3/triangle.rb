module Triangle
  module_function

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
