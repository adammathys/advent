require "minitest/autorun"
require_relative "maze"

class MazeTest < Minitest::Test
  INPUT = <<-EOS
     |
     |  +--+
     A  |  C
 F---|----E|--+
     |  |  |  D
     +B-+  +--+
  EOS

  def setup
    @maze = Maze.new(INPUT)
    @maze.run!
  end

  def test_visited
    assert_equal "ABCDEF", @maze.visited
  end

  def test_steps
    assert_equal 38, @maze.steps
  end
end
