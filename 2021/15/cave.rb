require "set"

class Cave
  def initialize(input)
    @grid = input.map{ _1.chars.map(&:to_i) }
  end

  def lowest_risk(max = false)
    grow_grid if max
    dijkstra
  end

  private

  def grow_grid
    ow = width
    oh = height

    (1...5).each do
      first = (ow + 1) * _1
      last = first + ow
      (0..oh).each do |y|
        (first..last).each do |x|
          @grid[y] << (@grid[y][x - oh - 1] % 9) + 1
        end
      end
    end

    (1...5).each do
      first = (oh + 1) * _1
      last = first + oh

      (first..last).each do |y|
        @grid << (0..width).map do |x|
          (@grid[y - oh - 1][x] % 9) + 1
        end
      end
    end
  end

  # Based on pseudocode here: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
  def dijkstra(start = [0,0], target = [width, height])
    distances = {}
    (0..height).each{ |y| (0..width).each{ |x| distances[[x, y]] = infinity } }
    distances[start] = 0

    queue = Set[start]

    until queue.empty?
      u = queue.min_by{distances[_1]}
      break if u == target

      queue.delete(u)

      neighbours(*u).each do |neighbour|
        alt = distances[u] + risk(*neighbour)
        if alt < distances[neighbour]
          distances[neighbour] = alt
          queue << neighbour
        end
      end
    end

    distances[target]
  end

  def risk(x, y)
    @grid[y][x]
  end

  def neighbours(x, y)
    [
      [-1,  0],
      [ 0, -1],
      [ 1,  0],
      [ 0,  1],
    ].map{ |a, b|
      x1, y1 = x + a, y + b
      [x1, y1] if (0..width) === x1 && (0..height) === y1
    }.compact
  end

  def width
    @grid[0].length - 1
  end

  def height
    @grid.length - 1
  end

  def infinity
    height * width * 10
  end
end
