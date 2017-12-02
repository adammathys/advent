class Solution
  class << self
    def firstStar(input)
      input.lines.map do |line|
        numbers = line.split.map(&:to_i)
        numbers.max - numbers.min
      end.sum
    end

    def secondStar(input)
      input.lines.flat_map do |line|
        n = line.split.map(&:to_i)
        n.flat_map { |x| (n - [x]).map { |y| division(x, y) } }
        end
      end.sum
    end

    private

    def division(x, y)
      (x % y == 0) ? x/y : 0
    end
  end
end
