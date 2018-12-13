class Garden
  attr_reader :initial, :rules

  def initialize(initial:, rules:)
    @initial = initial.split("")
    @rules = rules
  end

  def yield(generations:)
    offset = 0
    pots = pad(initial.dup, 5)

    generations.times do |t|
      new_pots = Array.new(pots.rindex("#") + 10) { "." }
      0.upto(new_pots.size) do |i|
        k = key(pots, i)
        new_pots[i] = rules.fetch(k, ".")
      end

      if match?(pots, new_pots)
        pots = new_pots
        offset = generations - t - 1
        break
      else
        pots = new_pots
      end
    end

    sum(pots, offset)
  end

  private

  def sum(pots, offset)
    pots.each_index.select { |i| pots[i] == "#" }.map{ |k| (k - 5) + offset }.sum
  end

  def pad(pots, offset)
    offset.times { pots.unshift(".") }
    pots
  end

  def key(pots, i)
    -2.upto(2).map do |x|
      if (i + x) < 0
        "."
      else
        pots.fetch(i + x, ".")
      end
    end.join
  end

  def match?(a, b)
    as = a.index("#")
    ae = a.rindex("#")
    bs = b.index("#")
    be = b.rindex("#")

    a[as..ae] == b[bs..be]
  end
end
