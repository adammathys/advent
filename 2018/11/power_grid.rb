class PowerGrid
  SIZE = 300

  Cell = Struct.new(:position, :power)

  attr_reader :serial_number

  def initialize(serial_number:)
    @serial_number = serial_number
  end
  
  def variable_max_power
    max = [0, Cell.new([0, 0], 0)]

    1.upto(SIZE - 1) do |t|
      current = max_power(grid_size: t)
      max = [t, current] if current.power >= max[1].power
    end

    max
  end

  def max_power(grid_size: 3)
    max = Cell.new([0, 0], 0)

    1.upto(SIZE - grid_size) do |x|
      1.upto(SIZE - grid_size) do |y|
        power = cluster_power(x - 1, y - 1, grid_size)
        current = Cell.new([x, y], power)
        max = current if current.power > max.power
      end
    end

    max
  end

  private

  def grid
    @grid ||= begin
      0.upto(SIZE - 1).map do |y|
        0.upto(SIZE - 1).map do |x|
          rack_id = x + 10
          level = ((rack_id * y) + serial_number) * rack_id
          ((level / 100) % 10) - 5
        end
      end
    end
  end

  def sum
    @sum ||= begin
      m = Array.new(SIZE) { Array.new(SIZE, 0) }
      m[0][0] = grid[0][0]
      1.upto(SIZE - 1) do |t|
        m[0][t] = grid[0][t] + m[0][t-1]
        m[t][0] = grid[t][0] + m[t-1][0]
      end
      1.upto(SIZE - 1) do |y|
        1.upto(SIZE - 1) do |x|
          m[y][x] = grid[y][x] + m[y-1][x] + m[y][x-1] - m[y-1][x-1]
        end
      end
      m
    end
  end

  def cluster_power(x, y, w)
    sum[y][x] + sum[y+w][x+w] - sum[y+w][x] - sum[y][x+w]
  end
end
