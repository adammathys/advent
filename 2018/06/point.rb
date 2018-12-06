class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def distance(other)
    (x - other.x).abs + (y - other.y).abs
  end

  def +(other)
    Point.new(
      self.x + other.x,
      self.y + other.y
    )
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def inspect
    "Point(#{x},#{y})"
  end
end
