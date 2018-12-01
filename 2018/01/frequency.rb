require 'set'

class Frequency
  def initialize(input)
    @input = input.map{ |x| x.chomp.to_i }
  end

  def sum
    @input.sum
  end

  def first_duplicate
    seen = Set.new

    sum = 0
    index = 0

    while seen.add?(sum)
      sum += @input[index % @input.length]
      index += 1
    end

    sum
  end
end