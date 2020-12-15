class Game
  def initialize(start)
    @start = start
  end

  def spoken(index)
    last_index = Array.new(index)
    @start.each_with_index { |s, i| last_index[s] = i + 1 }

    prev = @start.last

    (@start.length..index).each do |i|
      prev_idx, last_index[prev] = last_index[prev], i
      prev = prev_idx ? (i - prev_idx) : 0
    end

    prev
  end
end
