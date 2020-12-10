require "minitest/autorun"
require_relative "adapter"

class Test < Minitest::Test
  def test_jolt_differences
    adapter = Adapter.new([
      16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4
    ])
    assert_equal [7, 5], adapter.jolt_differences
  end

  def test_arrangements
    adapter = Adapter.new([
      16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4
    ])
    assert_equal 8, adapter.arrangements

    adapter = Adapter.new([
      28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11,
      1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3
    ])
    assert_equal 19208, adapter.arrangements
  end
end
