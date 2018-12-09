require "minitest/autorun"
require_relative "marbles"

class MarblesTest < Minitest::Test
  def test_high_score
    game = Marbles.new(players: 9, rounds: 25)
    assert_equal 32, game.high_score

    game = Marbles.new(players: 10, rounds: 1618)
    assert_equal 8_317, game.high_score

    game = Marbles.new(players: 13, rounds: 7999)
    assert_equal 146_373, game.high_score

    game = Marbles.new(players: 17, rounds: 1104)
    assert_equal 2_764, game.high_score

    game = Marbles.new(players: 21, rounds: 6111)
    assert_equal 54_718, game.high_score

    game = Marbles.new(players: 30, rounds: 5807)
    assert_equal 37_305, game.high_score
  end
end
