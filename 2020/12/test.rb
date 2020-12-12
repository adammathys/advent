require "minitest/autorun"
require_relative "voyage"

class VoyageTest < Minitest::Test
  def test_simulate
    voyage = Voyage.new(%w(F10 N3 F7 R90 F11))
    voyage.simulate
    assert_equal 25, voyage.ship.distance(Vector[0,0])
  end

  def test_simulate_waypoint
    voyage = Voyage.new(%w(F10 N3 F7 R90 F11))
    voyage.simulate(true)
    assert_equal 286, voyage.ship.distance(Vector[0,0])
  end
end
