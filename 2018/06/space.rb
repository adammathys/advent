require_relative "point"

class Space
  def initialize(input)
    @points = input.map.with_index do |coordinate, index|
      [index, Point.new(*coordinate.split(", ").map(&:to_i))]
    end.to_h
  end

  def largest_area
    space = grid do |g, x, y|
      adjusted = Point.new(x, y) + top_left
      g[x][y] = unique_closest(adjusted)
    end
    contained_points.map do |id, _|
      space.sum { |r| r.count(id) }
    end.max
  end

  def safe_area(delta: 32)
    space = grid do |g, x, y|
      adjusted = Point.new(x, y) + top_left
      if distances(adjusted).values.sum < delta
        g[x][y] = "#"
      end
    end
    space.sum { |r| r.count("#") }
  end

  private

  def distances(point)
    @points.map do |id, origin|
      [id, origin.distance(point)]
    end.to_h
  end

  def unique_closest(point)
    distances = distances(point)
    id, min = distances.min_by { |_, dist| dist }
    distances.values.count(min) == 1 ? id : nil
  end

  def contained_points
    rejects = []
    0.upto(width) do |x|
      rejects << unique_closest(Point.new(x, 0))
      rejects << unique_closest(Point.new(x, height))
    end
    0.upto(height) do |y|
      rejects << unique_closest(Point.new(0, y))
      rejects << unique_closest(Point.new(width, y))
    end
    rejects = rejects.compact.uniq

    @points.reject { |k,_| rejects.include?(k) }
  end

  def top_left
    @top_left ||= Point.new(
      @points.values.min_by(&:x).x,
      @points.values.min_by(&:y).y
    )
  end

  def bottom_right
    @bottom_right ||= Point.new(
      @points.values.max_by(&:x).x,
      @points.values.max_by(&:y).y
    )
  end

  def width
    bottom_right.x - top_left.x + 1
  end

  def height
    bottom_right.y - top_left.y + 1
  end

  def grid
    space = Array.new(width) { Array.new(height) }
    space.each_with_index do |row, x|
      row.each_with_index do |_, y|
        yield(space, x, y)
      end
    end
    space
  end
end
