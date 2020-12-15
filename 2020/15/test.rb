require "minitest/autorun"
require_relative "game"

class GameTest < Minitest::Test
  def test_spoken
    game = Game.new([0,3,6])
    assert_equal 0, game.spoken(3)
    assert_equal 3, game.spoken(4)
    assert_equal 3, game.spoken(5)
    assert_equal 1, game.spoken(6)
    assert_equal 0, game.spoken(7)
    assert_equal 4, game.spoken(8)
    assert_equal 0, game.spoken(9)
    assert_equal 436, game.spoken(2019)
  end

  def test_large_spoken
    assert_equal 175594, Game.new([0,3,6]).spoken(30000000 - 1)
  end
end
