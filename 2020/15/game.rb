require "pry"

class Game
  def initialize(start)
    @seen = Array.new
    @last_index = Hash.new { |h,k| h[k] = [] }

    start.each_with_index do |s,i|
      @seen[i] = s
      @last_index[s].push(i)
    end
  end

  def spoken(index)
    (0..index).each do |i|
      next if @seen[i]

      prev = @seen[i-1]
      prev_idx = @last_index[prev]

      v = prev_idx.length <= 1 ? 0 : (i - prev_idx.shift - 1)

      @last_index[v].push(i)
      @seen[i] = v
    end

    @seen[index]
  end
end
