class Forest
  TREE = '#'
  EMPTY = '.'

  def initialize(rows)
    @rows = rows.map{ |row| row.strip.split('') }
  end

  def tree?(pos)
    x, y = pos.to_a
    x %= width
    @rows[y][x] == TREE
  end

  def height
    @rows.length
  end

  def width
    @rows[0].length
  end
end
