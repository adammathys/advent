require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_simple_score
    assert_equal 1, Solution.new("{}").score
  end

  def test_nested_groups_score
    assert_equal 6, Solution.new("{{{}}}").score
    assert_equal 5, Solution.new("{{},{}}").score
    assert_equal 16, Solution.new("{{{},{},{{}}}}").score
  end

  def test_garbage_score
    assert_equal 1, Solution.new("{<a>,<a>,<a>,<a>}").score
    assert_equal 9, Solution.new("{{<ab>},{<ab>},{<ab>},{<ab>}}").score
    assert_equal 9, Solution.new("{{<!!>},{<!!>},{<!!>},{<!!>}}").score
    assert_equal 3, Solution.new("{{<a!>},{<a!>},{<a!>},{<ab>}}").score
  end
end
