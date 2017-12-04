class Solution
  class << self
    def first(input)
      rings = 0
      max = 1
      while (max ** 2) < input
        max += 2
        rings += 1
      end
      start = ((max - 2) ** 2) + (max / 2)

      centers = (0..3).map { |i| start + ((max - 1) * i) }
      offset = centers.map { |x| (x - input).abs }.min

      offset + rings
    end

    def second(input)
      grid = [[1], [1]]
      counter = increment(grid)
      while counter <= input
        grid = rotate(grid) if grid[0].size > grid[1].size
        grid[0] << (counter = increment(grid))
      end
      grid[0].last
    end

    private

    def rotate(grid)
      (grid[0].size - 1).downto(0).map do |i|
        grid.map { |row| row.fetch(i, nil) }.compact
      end
    end

    def increment(grid)
      values = (0..2).map do |i|
        grid[1].fetch((grid[0].size - 1) + i, nil)
      end
      values << grid[0].last
      values.compact.sum
    end
  end
end
