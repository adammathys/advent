class Origami
  def initialize(points)
    @points = points.map{ _1.split(",").map(&:to_i) }
  end

  def fold(x: nil, y: nil)
    if x
      @points.each{ _1[0] -= (_1[0] - x) * 2 if _1[0] > x }.uniq!
    elsif y
      @points.each{ _1[1] -= (_1[1] - y) * 2 if _1[1] > y }.uniq!
    end
  end

  def to_s
    (0..height).map { |y|
      (0..width).map { |x|
        @points.include?([x, y]) ? '#' : ' '
      }.join
    }.join("\n")
  end

  private

  def height
    @points.map(&:last).max
  end

  def width
    @points.map(&:first).max
  end
end
