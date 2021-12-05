require "matrix"

class Vents
  class Line
    def initialize(coords)
      ab, xy = coords.split(" -> ")

      @start = Vector[*ab.split(",").map(&:to_i)]
      @stop = Vector[*xy.split(",").map(&:to_i)]
    end

    def diagonal?
      start[0] != stop[0] && start[1] != stop[1]
    end

    def points
      (0..length).map{start + (direction * _1)}
    end

    private

    attr_reader :start, :stop

    def length
      xlen = (start[0] - stop[0]).abs
      xlen == 0 ? (start[1] - stop[1]).abs : xlen
    end

    def direction
      Vector[stop[0] <=> start[0], stop[1] <=> start[1]]
    end
  end

  def initialize(coords)
    @lines = coords.map{Line.new(_1)}
  end

  def overlaps(diagonals = false)
    lines = diagonals ? @lines : @lines.reject(&:diagonal?)
    overlaps = Hash.new(0)

    lines.each do |line|
      line.points.each{overlaps[_1] += 1}
    end

    overlaps.count{_2 > 1}
  end
end
