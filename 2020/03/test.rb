require "minitest/autorun"
require_relative "solution"

class Test < Minitest::Test
  def test_trees_encountered
    solution = Solution.new([
      "..##.......",
      "#...#...#..",
      ".#....#..#.",
      "..#.#...#.#",
      ".#...##..#.",
      "..#.##.....",
      ".#.#.#....#",
      ".#........#",
      "#.##...#...",
      "#...##....#",
      ".#..#...#.#",
    ])
    assert_equal 7, solution.trees_encountered
    assert_equal 2, solution.trees_encountered(Vector[1,1])
    assert_equal 3, solution.trees_encountered(Vector[5,1])
    assert_equal 4, solution.trees_encountered(Vector[7,1])
    assert_equal 2, solution.trees_encountered(Vector[1,2])
  end
end
