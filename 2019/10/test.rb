require "minitest/autorun"
require_relative "astroid_map"

class AstroidMapTest < Minitest::Test
  def test_best_location
    astroid_map = AstroidMap.new([
      ".#..#",
      ".....",
      "#####",
      "....#",
      "...##"
    ])
    assert_equal [3,4], astroid_map.best_location
    assert_equal 8, astroid_map.num_detected(3, 4)
  end

  def test_alternative_maps
    astroid_map = AstroidMap.new([
      "......#.#.",
      "#..#.#....",
      "..#######.",
      ".#.#.###..",
      ".#..#.....",
      "..#....#.#",
      "#..#....#.",
      ".##.#..###",
      "##...#..#.",
      ".#....####",
    ])
    assert_equal [5,8], astroid_map.best_location

    astroid_map = AstroidMap.new([
      "#.#...#.#.",
      ".###....#.",
      ".#....#...",
      "##.#.#.#.#",
      "....#.#.#.",
      ".##..###.#",
      "..#...##..",
      "..##....##",
      "......#...",
      ".####.###.",
    ])
    assert_equal [1,2], astroid_map.best_location

    astroid_map = AstroidMap.new([
      ".#..#..###",
      "####.###.#",
      "....###.#.",
      "..###.##.#",
      "##.##.#.#.",
      "....###..#",
      "..#.#..#.#",
      "#..#.#.###",
      ".##...##.#",
      ".....#.#..",
    ])
    assert_equal [6,3], astroid_map.best_location

    astroid_map = AstroidMap.new([
      ".#..##.###...#######",
      "##.############..##.",
      ".#.######.########.#",
      ".###.#######.####.#.",
      "#####.##.#.##.###.##",
      "..#####..#.#########",
      "####################",
      "#.####....###.#.#.##",
      "##.#################",
      "#####.##.###..####..",
      "..######..##.#######",
      "####.##.####...##..#",
      ".#####..#.######.###",
      "##...#.##########...",
      "#.##########.#######",
      ".####.#.###.###.#.##",
      "....##.##.###..#####",
      ".#.#.###########.###",
      "#.#.#.#####.####.###",
      "###.##.####.##.#..##",
    ])
    assert_equal [11,13], astroid_map.best_location
  end

  def test_nth_vaporized
    astroid_map = AstroidMap.new([
      ".#..##.###...#######",
      "##.############..##.",
      ".#.######.########.#",
      ".###.#######.####.#.",
      "#####.##.#.##.###.##",
      "..#####..#.#########",
      "####################",
      "#.####....###.#.#.##",
      "##.#################",
      "#####.##.###..####..",
      "..######..##.#######",
      "####.##.####...##..#",
      ".#####..#.######.###",
      "##...#.##########...",
      "#.##########.#######",
      ".####.#.###.###.#.##",
      "....##.##.###..#####",
      ".#.#.###########.###",
      "#.#.#.#####.####.###",
      "###.##.####.##.#..##",
    ])
    assert_equal [11, 12], astroid_map.nth_vaporized(1)
    assert_equal [12, 1], astroid_map.nth_vaporized(2)
    assert_equal [12, 8], astroid_map.nth_vaporized(10)
    assert_equal [10, 16], astroid_map.nth_vaporized(100)
    assert_equal [8, 2], astroid_map.nth_vaporized(200)
  end
end