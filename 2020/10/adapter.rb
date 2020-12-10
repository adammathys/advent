class Adapter
  def initialize(jolts)
    @jolts = [0] + jolts.sort + [jolts.max + 3]
  end

  def jolt_differences
    deltas = Hash.new(0)
    @jolts.each_cons(2) { |a, b| deltas[b - a] += 1 }
    deltas.values
  end

  def arrangements(jolt = 0)
    return 1 if jolt == @jolts.max
    arrangements_cache(jolt)
  end

  private

  def arrangements_cache(jolt)
    @cache ||= Hash.new do |h, k|
      h[k] = options(k).map { |i| arrangements(i) }.sum
    end
    @cache[jolt]
  end

  def options(jolt)
    @jolts.select { |j| (j - jolt).between?(1, 3) }
  end
end
