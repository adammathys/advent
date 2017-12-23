require "matrix"

class Weak
  UP = Vector[0, -1]
  DOWN = Vector[0, 1]
  LEFT = Vector[-1, 0]
  RIGHT = Vector[1, 0]

  INFECTED = "#".freeze
  CLEAN = ".".freeze
  WEAKENED = "W".freeze
  FLAGGED = "F".freeze

  def initialize(grid)
    @starting_grid = grid.lines.map(&:strip).map(&:chars)
  end

  def burst(count)
    grid = @starting_grid.map(&:dup)
    direction = UP
    current = Vector[(grid.size - 1) / 2, (grid.size - 1) / 2]

    infected = 0

    count.times do |i|
      grid, current = grow_grid(grid, current)
      x, y = current.to_a
      case grid[y][x]
      when INFECTED
        direction = turn_right(direction)
        grid[y][x] = FLAGGED
      when CLEAN
        direction = turn_left(direction)
        grid[y][x] = WEAKENED
      when WEAKENED
        grid[y][x] = INFECTED
        infected += 1
      when FLAGGED
        direction = turn_around(direction)
        grid[y][x] = CLEAN
      end

      current += direction
    end

    infected
  end

  private

  def grow_grid(grid, position)
    x, y = position.to_a

    if y < 0
      grid.unshift(Array.new(grid[0].size, CLEAN))
      y = 0
    elsif y > grid.size - 1
      grid.push(Array.new(grid[0].size, CLEAN))
    end

    if x < 0
      grid.each { |row| row.unshift(CLEAN) }
      x = 0
    elsif x > grid[0].size - 1
      grid.each { |row| row.push(CLEAN) }
    end

    [grid, Vector[x, y]]
  end

  def turn_right(direction)
    case direction
    when UP
      RIGHT
    when DOWN
      LEFT
    when LEFT
      UP
    when RIGHT
      DOWN
    end
  end

  def turn_left(direction)
    case direction
    when UP
      LEFT
    when DOWN
      RIGHT
    when LEFT
      DOWN
    when RIGHT
      UP
    end
  end

  def turn_around(direction)
    case direction
    when UP
      DOWN
    when DOWN
      UP
    when LEFT
      RIGHT
    when RIGHT
      LEFT
    end
  end
end
