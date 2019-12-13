require "matrix"
require_relative "intcode"

class Game
  attr_reader :tiles

  def initialize(state)
    @intcode = Intcode.new(state)
    @current_score = 0
    @tiles = {}
  end

  def run
    paddle_move = 0
    until @intcode.halted?
      x = @intcode.run(paddle_move)
      y = @intcode.run(paddle_move)
      z = @intcode.run(paddle_move)

      if x == -1 && y == 0
        @current_score = z
      else
        @tiles[Vector[x,y]] = z
      end

      paddle = @tiles.key(3)
      ball = @tiles.key(4)
      if paddle && ball
        paddle_move = ball[0] <=> paddle[0]
      end
    end

    @current_score
  end
end
