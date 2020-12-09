class Xmas
  def initialize(numbers)
    @numbers = numbers
  end

  def find_weakness(preamble = 25)
    index = preamble

    loop do
      combos = @numbers[index - preamble, preamble].combination(2)
      break unless combos.any?{ |c| c.sum == @numbers[index] }
      index += 1
    end

    @numbers[index]
  end

  def encryption_weakness(preamble = 25)
    weakness = find_weakness(preamble)
    (2..@numbers.length).each do |i|
      @numbers.each_cons(i) do |range|
        return (range.minmax.sum) if range.sum == weakness
      end
    end
  end
end
