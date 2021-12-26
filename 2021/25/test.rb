require "minitest/autorun"
require_relative "cucumbers"

class CucumbersTest < Minitest::Test
  def setup
    input = [
      "v...>>.vv>",
      ".vv>>.vv..",
      ">>.>v>...v",
      ">>v>>.>.v.",
      "v>v.vv.v..",
      ">.>>..v...",
      ".vv..>.>v.",
      "v.v..>>v.v",
      "....v..v.>"
    ]
    @cucumbers = Cucumbers.new(input)
  end

  def test_move
    assert_equal 58, @cucumbers.move!
  end
end
