class Solution
  def self.part1(x)
    x.each_char.with_index.map do |c, i|
      c == x[(i + 1) % x.length] ? c.to_i : 0
    end.sum
  end

  def self.part2(x)
    steps = x.length / 2
    x.each_char.with_index.map do |c, i|
      c == x[(i + steps) % x.length] ? c.to_i : 0
    end.sum
  end
end
