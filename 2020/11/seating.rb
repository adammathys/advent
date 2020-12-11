require "matrix"

class Seating
  FLOOR = "."
  EMPTY = "L"
  OCCUPIED = "#"

  def initialize(seats)
    @rows = seats.map { |row| row.strip.chars }
  end

  def stable(ignore_floor = false)
    loop do
      next_rows = step(ignore_floor)
      break if next_rows == @rows
      @rows = next_rows
    end

    @rows.sum { |row| row.count { |s| s == OCCUPIED } }
  end

  private

  def step(ignore_floor)
    required = ignore_floor ? 5 : 4
    new_rows = []

    @rows.each_with_index do |row, y|
      new_rows << []
      row.each_with_index do |spot, x|
        case spot
        when EMPTY
          free = neighbours(x, y, ignore_floor).all? { |n| n == EMPTY || n == FLOOR }
          new_rows[y][x] = free ? OCCUPIED : EMPTY
        when OCCUPIED
          occupied = neighbours(x, y, ignore_floor).count { |n| n == OCCUPIED }
          new_rows[y][x] = (occupied >= required) ? EMPTY : OCCUPIED
        when FLOOR
          new_rows[y][x] = FLOOR
        end
      end
    end

    new_rows
  end

  def neighbours(x, y, ignore_floor)
    pos = Vector[x, y]
    [
      Vector[-1, -1], Vector[-1, 0], Vector[-1, 1],
      Vector[0, -1], Vector[0, 1],
      Vector[1, -1], Vector[1, 0], Vector[1, 1]
    ].map { |vector|
      ignore_floor ? line(pos + vector, vector) : space(pos + vector)
    }.compact
  end

  def line(pos, vector)
    loop do
      spot = space(pos)
      break spot unless spot == FLOOR
      pos += vector
    end
  end

  def space(pos)
    x, y = pos.to_a
    @rows[y][x] unless x < 0 || x >= width || y < 0 || y >= height
  end

  def width
    @rows[0].length
  end

  def height
    @rows.length
  end
end
