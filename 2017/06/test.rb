require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_redistribution_cycles
    input = "0 2 7 0"
    assert Solution.(input) == 5
  end

  def test_loop_cycles
    input = "0 2 7 0"
    assert Solution.(input, infinite: true) == 4
  end
end
