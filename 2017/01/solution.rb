class Solution
  def self.part1(x)
    sum = 0

    x.each_char.with_index do |char, index|
      if char == x[(index + 1) % x.length]
        sum += char.to_i
      end
    end

    sum
  end

  def self.part2(x)
    steps = x.length / 2
    sum = 0

    x.each_char.with_index do |char, index|
      if char == x[(index + steps) % x.length]
        sum += char.to_i
      end
    end

    sum
  end
end
