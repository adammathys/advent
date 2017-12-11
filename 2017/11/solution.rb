class Solution
  def initialize(input)
    @directions = input.strip.split(",")
  end

  def steps
    optimized = optimize(@directions)

    loop do
      new = optimize(optimized)
      break if optimized.size == new.size
      optimized = new
    end

    optimized.size
  end

  private

  def optimize(directions)
    optimized = directions.dup
    optimize_zigzag(optimized, "nw", "s", "sw")
    optimize_zigzag(optimized, "ne", "s", "se")
    optimize_zigzag(optimized, "sw", "n", "nw")
    optimize_zigzag(optimized, "sw", "n", "ne")

    remove_backtracks(optimized, "ne", "sw")
    remove_backtracks(optimized, "nw", "se")
    remove_backtracks(optimized, "n", "s")

    optimize_zigzag(optimized, "sw", "se", "s")
    optimize_zigzag(optimized, "nw", "ne", "n")

    optimized
  end

  def remove_backtracks(directions, a, b)
    [directions.count(a), directions.count(b)].min.times do
      directions.delete_at(directions.index(a))
      directions.delete_at(directions.index(b))
    end
  end

  def optimize_zigzag(directions, a, b, c)
    [directions.count(a), directions.count(b)].min.times do
      directions.delete_at(directions.index(a))
      directions.delete_at(directions.index(b))
      directions.push(c)
    end
  end
end
