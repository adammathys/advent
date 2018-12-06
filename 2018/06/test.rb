require "minitest/autorun"
require_relative "space"

class Test < Minitest::Test
  INPUT = [
    "1, 1",
    "1, 6",
    "8, 3",
    "3, 4",
    "5, 5",
    "8, 9"
  ]

  def test_largest_area
    assert_equal 17, Space.new(INPUT).largest_area()
  end

  def test_safe_area
    assert_equal 16, Space.new(INPUT).safe_area()
  end
end
