class Lanternfish
  def initialize(starters)
    @fishes = starters.split(",").map(&:to_i)
  end

  def count(days)
    counts = @fishes.tally
    days.times do
      counts = shift(counts)
      counts[8] = counts.delete(-1){0}
      counts[6] += counts[8]
    end
    counts.sum{_2}
  end

  private

  def shift(hash)
    Hash.new(0).merge(hash.to_h{[_1-1,_2]})
  end
end
