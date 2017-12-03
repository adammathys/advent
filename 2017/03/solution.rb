class Solution
  class << self
    def first(input)
      rings = 0
      max = 1
      while (max ** 2) < input
        max += 2
        rings += 1
      end
      inner = (max - 2) ** 2
      start = inner + (max / 2)

      centers = []
      (0..3).each do |i|
        centers.push(start + ((max - 1) * i))
      end

      offset = centers.map { |x| (x - input).abs }.min
      offset + rings
    end

    def second(input)
      grid = [[1], [1]]
      counter = 2
      while (counter <= input)
        if grid[0].length > grid[1].length
          grid = rotate(grid)
        end
        counter = increment(grid)
        grid[0].push(counter)
      end
      grid[0].last
    end

    private

    def rotate(grid)
      result = []
      (grid[0].length - 1).downto(0) do |i|
        tmp = []
        for row in grid do
          break unless row.fetch(i, nil)
          tmp << row[i]
        end
        result << tmp
      end
      result
    end

    def increment(grid)
      values = (0..2).map do |i|
        grid[1].fetch((grid[0].length - 1) + i, nil)
      end
      values << grid[0].last
      values.compact.sum
    end
  end
end
