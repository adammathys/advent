require "minitest/autorun"
require_relative "sub"

class Test < Minitest::Test
  def setup
    @instructions = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]
  end

  def test_move
    assert_equal [15, 10, 60], Sub.move(@instructions)
  end
end
