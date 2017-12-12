require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  INPUT = <<~EOS
    0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5
  EOS

  def test_group_size
    assert_equal 6, Solution.new(INPUT).group_size(0)
  end

  def test_group_count
    assert_equal 2, Solution.new(INPUT).group_count
  end
end
