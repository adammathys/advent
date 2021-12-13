require "minitest/autorun"
require_relative "origami"

class OrigamiTest < Minitest::Test
  def setup
    input = [
      "6,10",
      "0,14",
      "9,10",
      "0,3",
      "10,4",
      "4,11",
      "6,0",
      "6,12",
      "4,1",
      "0,13",
      "10,12",
      "3,4",
      "3,0",
      "8,4",
      "1,10",
      "2,14",
      "8,10",
      "9,0"
    ]
    @origami = Origami.new(input)
  end

  def test_fold
    assert_equal [
      [6, 4],
      [0, 0],
      [9, 4],
      [0, 3],
      [10, 4],
      [4, 3],
      [6, 0],
      [6, 2],
      [4, 1],
      [0, 1],
      [10, 2],
      [3, 4],
      [3, 0],
      [8, 4],
      [1, 4],
      [2, 0],
      [9, 0]
    ], @origami.fold(y: 7)
  end
end
