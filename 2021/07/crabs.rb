class Crabs
  def initialize(positions)
    @crabs = positions.split(",").map(&:to_i).sort
  end

  def min(constant = true)
    if constant
      @crabs.sum{(_1-median).abs}.to_i
    else
      (-1..1).map do |i|
        @crabs.sum{cost((_1-(mean + i)).abs)}.to_i
      end.min
    end
  end

  private

  def cost(distance)
    distance * (distance + 1) / 2
  end

  def median
    mid = (@crabs.length - 1) / 2.0
    (@crabs[mid.floor] + @crabs[mid.ceil]) / 2.0
  end

  def mean
    (@crabs.sum / (@crabs.length * 1.0)).round
  end
end
