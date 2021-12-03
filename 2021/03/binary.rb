class Binary
  def initialize(input)
    @input = input.map(&:chomp)
  end

  def gamma
    (0...num_bits).map{most_common(@input, _1)}.join.to_i(2)
  end

  def epsilon
    gamma ^ ((1 << num_bits) - 1)
  end

  def oxygen
    filter(@input, 0).to_i(2)
  end

  def co2
    filter(@input, 0, :reject).to_i(2)
  end

  private

  def num_bits
    @input[0].length
  end

  def filter(list, idx, method = :select)
    return list.first if list.length == 1

    common = most_common(list, idx)
    filter(list.send(method){_1[idx] == common}, idx + 1, method)
  end

  def most_common(list, idx)
    list.sum{_1[idx].to_i} >= (list.length / 2.0) ? "1" : "0"
  end
end
