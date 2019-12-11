require "pry"
require "matrix"
require_relative "intcode"

class Robot
  attr_reader :grid, :intcode

  BLACK = "░".freeze
  WHITE = "█".freeze

  UP = Vector[0,-1]
  RIGHT = Vector[1,0]
  LEFT = Vector[-1,0]
  DOWN = Vector[0,1]

  def initialize(program)
    @grid = {}
    @intcode = Intcode.new(program)
  end

  def run
    direction = UP
    current = Vector[0,0]
    grid[current] = 1

    loop do
      color = intcode.run(grid.fetch(current, 0))
      turn = intcode.run

      break if intcode.halted?

      grid[current] = color
      direction =
        case direction
        when UP
          turn == 0 ? LEFT : RIGHT
        when RIGHT
          turn == 0 ? UP : DOWN
        when LEFT
          turn == 0 ? DOWN : UP
        when DOWN
          turn == 0 ? RIGHT : LEFT
        end
      current += direction
    end

    @grid.keys.length
  end

  def display
    y_vals.min.upto(y_vals.max) do |y|
      row = []

      x_vals.min.upto(x_vals.max) do |x|
        row << pixel(x, y)
      end

      puts row.join('')
    end
  end

  private

  def pixel(x, y)
    @grid.fetch(Vector[x,y], 0) == 0 ? BLACK : WHITE
  end

  def x_vals
    @grid.keys.map { |v| v[0] }
  end

  def y_vals
    @grid.keys.map { |v| v[1] }
  end
end
