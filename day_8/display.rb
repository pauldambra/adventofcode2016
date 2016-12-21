class Display
  def initialize(rows,columns)
    @pixels = []
    for r in 1..rows
      @pixels[r-1] = []
      for c in 1..columns
        @pixels[r-1][c-1] = '.'
      end
    end
  end

  def operate(operation)
    if operation.start_with? 'rect '
      draw_rectangle operation
    elsif operation.start_with? 'rotate column'
      rotate_column operation
    elsif operation.start_with? 'rotate row'
      rotate_row operation
    end

  end

  def show
    s = @pixels.map { |r| r.join('') + "\n" }.join('')
    s += "\n"
    puts s
    s
  end

  def pixels_lit
    # show
    @pixels.reduce(0) { |total, row| total + row.count { |x| x == '#' } }
  end

  def row(index)
    @pixels[index].map { |e| e }
  end

  def col(index)
    @pixels.map { |e| e[index] }
  end

  private

  def draw_rectangle(operation)
    x, y = operation.gsub('rect ', '').split('x')

    for row in 1..y.to_i
      for col in 1..x.to_i
        @pixels[row-1][col-1] = '#'
      end
    end
  end

  def rotate_column(operation)
    # rotate column x=A by B
    col, count = operation.split('=')[1].split(' by ').map { |x| x.to_i }
    column =  @pixels.map { |p| p[col] }

    for i in 0..count-1
      column = column.rotate(-1)
    end
    @pixels.each_with_index { |r, i| r[col] = column[i] }
    show
  end

  def rotate_row(operation)
    row_index, count = operation.split('=')[1].split(' by ').map { |x| x.to_i }
    row = @pixels[row_index]

    for i in 0..count-1
      row = row.rotate(-1)
    end
    @pixels[row_index] = row
  end
end