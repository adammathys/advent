require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  INPUT = <<-EOS
    b inc 5 if a > 1
    a inc 1 if b < 5
    c dec -10 if a >= 1
    c inc -20 if c == 10
  EOS

  def test_largest_value
    assert Solution.new(INPUT).largest_value == 1
  end

  def test_max
    assert Solution.new(INPUT).max == 10
  end
end
