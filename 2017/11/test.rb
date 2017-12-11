require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_simple_steps
    assert_equal 3, Solution.new("ne,ne,ne").walk
  end

  def test_backtracking_walk
    assert_equal 0, Solution.new("ne,ne,sw,sw").walk
  end

  def test_direction_switch_walk
    assert_equal 2, Solution.new("ne,ne,s,s").walk
  end

  def test_zigzag_walk
    assert_equal 3, Solution.new("se,sw,se,sw,sw").walk
  end

  def test_simple_walk_farthest
    assert_equal 3, Solution.new("ne,ne,ne").walk(farthest: true)
  end

  def test_backtracking_walk_fathest
    assert_equal 2, Solution.new("ne,ne,sw,sw").walk(farthest: true)
  end

  def test_direction_switch_walk_farthest
    assert_equal 2, Solution.new("ne,ne,s,s").walk(farthest: true)
  end

  def test_zigzag_walk_farthest
    assert_equal 3, Solution.new("se,sw,se,sw,sw").walk(farthest: true)
  end
end
