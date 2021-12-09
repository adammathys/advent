class Lava
  def initialize(input)
    @grid = input.map{_1.chars.map(&:to_i)}
  end

  def risk
    low_points.map{ |x, y| point(x, y) }.sum{_1 + 1}
  end

  def basin_sizes
    low_points.map{ basin_points(_1, [_1]).length }.sort
  end

  private

  def point(x, y)
    @grid[y][x]
  end

  def low_points
    (0...height).flat_map do |y|
      (0...width).map { |x|
        [x, y] if neighbours(x, y).all?{point(*_1) > point(x, y)}
      }.compact
    end
  end

  def basin_points(start, points)
    neighbours(*start).each do |n|
      next if points.include?(n)
      next if point(*n) == 9
      basin_points(n, points << n)
    end

    points
  end

  def neighbours(x, y)
    [[x - 1, y], [x, y - 1], [x, y + 1], [x + 1, y]].map{ |x, y|
      [x, y] if (0...width) === x && (0...height) === y
    }.compact
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end
end
