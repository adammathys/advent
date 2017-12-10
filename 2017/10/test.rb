require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_single_step_check
    assert_equal 2, Solution.new(5).check([3])
  end

  def test_two_step_check
    assert_equal 12, Solution.new(5).check([3, 4])
  end

  def test_multi_step_check
    assert_equal 12, Solution.new(5).check([3, 4, 1, 5])
  end

  def test_hash
    assert_equal "a2582a3a0e66e6e86e3812dcb672a272", Solution.new(256).knot_hash("")
    assert_equal "33efeb34ea91902bb2f59c9920caa6cd", Solution.new(256).knot_hash("AoC 2017")
    assert_equal "3efbe78a8d82f29979031a4aa0b16a9d", Solution.new(256).knot_hash("1,2,3")
    assert_equal "63960835bcdc130f0b66d7ff4f6a5a8e", Solution.new(256).knot_hash("1,2,4")
  end
end
