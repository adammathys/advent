class Spinlock
  def initialize(steps)
    @steps = steps
  end

  def happy
    buffer = [0]
    (1..2017).each do |i|
      buffer.rotate!(@steps)
      buffer.push(i)
    end
    index = (buffer.index(2017) + 1) % buffer.size
    buffer[index]
  end

  def angry
    current = result = 0
    (1..50_000_000).each do |i|
      current = ((current + @steps) % i) + 1
      result = i if current == 1
    end
    result
  end
end
