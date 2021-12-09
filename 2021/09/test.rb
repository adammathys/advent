require "minitest/autorun"
require_relative "lava"

class LavaTest < Minitest::Test
  def setup
    input = [
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678",
    ]
    @lava = Lava.new(input)
  end

  def test_risk
    assert_equal 15, @lava.risk
  end

  def test_basin_sizes
    assert_equal [3, 9, 9, 14], @lava.basin_sizes
  end
end
