require "minitest/autorun"
require_relative "cave"

class CaveTest < Minitest::Test
  def setup
    input = [
      "1163751742",
      "1381373672",
      "2136511328",
      "3694931569",
      "7463417111",
      "1319128137",
      "1359912421",
      "3125421639",
      "1293138521",
      "2311944581"
    ]
    @cave = Cave.new(input)
  end

  def test_lowest_risk
    assert_equal 40, @cave.lowest_risk
  end
end
