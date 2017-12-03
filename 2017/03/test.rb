require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_no_steps
    assert Solution.first(1) == 0
  end

  def test_12
    assert Solution.first(12) == 3
  end

  def test_23
    assert Solution.first(23) == 2
  end

  def test_1024
    assert Solution.first(1024) == 31
  end

  def test_easy
    assert Solution.second(1) == 1
  end

  def test_medium
    assert Solution.second(10) == 11
  end

  def test_larger
    assert Solution.second(50) == 54
  end

  def test_largest
    assert Solution.second(750) == 806
  end
end
