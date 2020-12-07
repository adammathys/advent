class Luggage
  Bag = Struct.new(:color, :children) do
    def contains?(color)
      if self.color == color
        true
      else
        children.keys.any?{ |c| c.contains?(color) }
      end
    end

    def sum
      children.sum do |child, count|
        count + (child.sum * count)
      end
    end
  end

  def initialize(rules)
    @bags = {}
    rules.each do |rule|
      color = /^(.*?) bags contain/.match(rule)[1]
      @bags[color] ||= Bag.new(color, {})

      rule.scan(/(\d+) (.*?) bag/).each do |count, child|
        @bags[child] ||= Bag.new(child, {})
        @bags[color].children[@bags[child]] = count.to_i
      end
    end
  end

  def count(color)
    @bags.values.count do |bag|
      bag.color != color && bag.contains?(color)
    end
  end

  def sum(color)
    @bags[color].sum
  end
end
