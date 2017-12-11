require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_simple_steps
    assert_equal 3, Solution.new("ne,ne,ne").steps
  end

  def test_backtracking_steps
    assert_equal 0, Solution.new("ne,ne,sw,sw").steps
  end

  def test_direction_switch_steps
    assert_equal 2, Solution.new("ne,ne,s,s").steps
  end

  def test_zigzag_steps
    assert_equal 3, Solution.new("se,sw,se,sw,sw").steps
  end
end
