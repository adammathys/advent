require "minitest/autorun"
require_relative "circuit"

class CircuitTest < Minitest::Test
  def test_closest_intersection
    assert_equal 159, Circuit.new([
      "R75,D30,R83,U83,L12,D49,R71,U7,L72",
      "U62,R66,U55,R34,D71,R55,D58,R83"
    ]).closest_intersection

    assert_equal 135, Circuit.new([
      "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
      "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    ]).closest_intersection
  end

  def test_fewest_steps
    assert_equal 610, Circuit.new([
      "R75,D30,R83,U83,L12,D49,R71,U7,L72",
      "U62,R66,U55,R34,D71,R55,D58,R83"
    ]).fewest_steps

    assert_equal 410, Circuit.new([
      "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
      "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    ]).fewest_steps
  end
end
