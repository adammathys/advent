class Checksum
  def initialize(input)
    @input = input.map(&:chars)
  end

  def sum
    twos = 0
    threes = 0

    @input.each do |id|
      counts = id.each_with_object(Hash.new(0)) { |x, h| h[x] += 1 }
      twos += 1 if counts.values.any?{ |x| x == 2 }
      threes += 1 if counts.values.any?{ |x| x == 3 }
    end

    twos * threes
  end

  def diff
    @input.each do |a|
      @input.each do |b|
        bad = 0
        a.each_with_index { |x, i| bad += 1 if x != b[i] }
        return (a - (a - b)).join if bad == 1
      end
    end

    return false
  end
end