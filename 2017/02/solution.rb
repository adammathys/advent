class Solution
  class << self
    def firstStar(input)
      input.split("\n").map do |line|
        numbers = line.split.map(&:to_i)
        numbers.max - numbers.min
      end.sum
    end

    def secondStar(input)
      input.split("\n").flat_map do |line|
        n = line.split.map(&:to_i)
        n.flat_map do |x|
          (n - [x]).map { |y| division(x, y) }
        end
      end.sum
    end

    private

    def division(x, y)
      (x > y) && (x % y == 0) ? x/y : 0
    end
  end
end
