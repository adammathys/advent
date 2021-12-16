class Polymer
  def initialize(template, rules)
    @rules = rules.map{ _1.split(" -> ") }.to_h
    @counts = Hash.new(0)
    @stats = Hash.new(0).merge(template.chars.tally)
    template.chars.each_cons(2).map{ @counts[_1.join] += 1 }
  end

  def insert
    new_counts = Hash.new(0)

    @counts.each do |pair, count|
      char = @rules[pair]

      new_counts["#{pair[0]}#{char}"] += count
      new_counts["#{char}#{pair[1]}"] += count

      @stats[char] += count
    end

    @counts = new_counts
  end

  def most_common
    @stats.values.max
  end

  def least_common
    @stats.values.min
  end
end
