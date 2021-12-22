require "minitest/autorun"
require_relative "game"

class GameTest < Minitest::Test
  def setup
    @game = Game.new([4, 8])
    @game.play!
  end

  def test_losing_score
    assert_equal 745, @game.losing_score
  end

  def test_rolls
    assert_equal 993, @game.rolls
  end
end
