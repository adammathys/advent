class Nanofactory
  attr_reader :formulae

  def initialize(input)
    @formulae = {}

    input.each do |raw_formula|
      formula = Formula.new(raw_formula)
      formulae[formula.output.name] = formula
    end
  end

  def fuel_cost(n = 1)
    needed = Hash.new(0)
    needed["FUEL"] = n

    loop do
      need, amount = needed.find do |name, quantity|
        quantity > 0 && name != "ORE"
      end

      break unless need

      formula = formulae[need]
      formula.needed_for(amount).each do |name, quantity|
        needed[name] += quantity
      end
      needed[need] -= formula.output_for(amount)
    end

    needed["ORE"]
  end

  def max_fuel
    trillion = 1_000_000_000_000
    # Seems unlikely we're going to be able to make more fuel than we have ore,
    # so a trillion is just a reasonably safe upper bound.
    (1..trillion).bsearch { |n| fuel_cost(n) > trillion } - 1
  end

  class Chemical
    attr_reader :name, :quantity

    def initialize(raw)
      quantity, name = raw.split

      @name = name.chomp
      @quantity = quantity.to_i
    end
  end

  class Formula
    attr_reader :output, :inputs

    def initialize(raw)
      inputs, output = raw.split(" => ")

      @output = Chemical.new(output)
      @inputs = inputs.split(", ").map do |input|
        Chemical.new(input)
      end
    end

    def needed_for(quantity)
      inputs.map do |input|
        [input.name, input.quantity * factor(quantity)]
      end
    end

    def output_for(quantity)
      output.quantity * factor(quantity)
    end

    private

    def factor(quantity)
      (quantity / output.quantity.to_f).ceil
    end
  end
end
