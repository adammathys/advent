require "minitest/autorun"
require_relative "elvish"

class ElvishTest < Minitest::Test
  INPUT = [
    "Step C must be finished before step A can begin.",
    "Step C must be finished before step F can begin.",
    "Step A must be finished before step B can begin.",
    "Step A must be finished before step D can begin.",
    "Step B must be finished before step E can begin.",
    "Step D must be finished before step E can begin.",
    "Step F must be finished before step E can begin.",
  ]

  def test_sort
    assert_equal "CABDFE", Elvish.new(INPUT).sort()
  end

  def test_time
    assert_equal 15, Elvish.new(INPUT).time()
  end
end
