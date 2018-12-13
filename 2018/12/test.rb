require "minitest/autorun"
require_relative "garden"

class GardenTest < Minitest::Test
  def test_yield
    initial = "#..#.#..##......###...###"
    rules = {
      "...##" => "#",
      "..#.." => "#",
      ".#..." => "#",
      ".#.#." => "#",
      ".#.##" => "#",
      ".##.." => "#",
      ".####" => "#",
      "#.#.#" => "#",
      "#.###" => "#",
      "##.#." => "#",
      "##.##" => "#",
      "###.." => "#",
      "###.#" => "#",
      "####." => "#"
    }
    garden = Garden.new(initial: initial, rules: rules)
    assert_equal 325, garden.yield(generations: 20)
  end
end
