class Solution
  def self.call(x, s = 1)
    x.each_char.with_index.map do |c, i|
      c == x[(i + s) % x.length] ? c.to_i : 0
    end.sum
  end
end
