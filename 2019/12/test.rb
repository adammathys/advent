require "minitest/autorun"
require_relative "moon"

class MoonTest < Minitest::Test
  def test_kinetic
    moon = Moon.new(1, 1, 1)
    moon.instance_variable_set(:@velocity, Vector[1, 2, 3])
    assert_equal 6, moon.kinetic
  end

  def test_potential
    moon = Moon.new(3, 6, 1)
    assert_equal 10, moon.potential
  end

  def test_total_energy
    moon = Moon.new(3, 6, 1)
    moon.instance_variable_set(:@velocity, Vector[1, 2, 3])
    assert_equal 60, moon.total_energy
  end

  def test_apply_gravity
    moon = Moon.new(-1, 0, 2)
    other_moons = [
      Moon.new(2, -10, -7),
      Moon.new(4, -8, 8),
      Moon.new(3, 5, -1)
    ]
    moon.apply_gravity(other_moons)
    assert_equal Vector[3, -1, -1], moon.velocity
  end

  def test_move
    moon = Moon.new(3, 6, 1)
    moon.instance_variable_set(:@velocity, Vector[-1, 2, -1])
    assert_equal Vector[2, 8, 0], moon.move
  end

  def test_equal
    moon = Moon.new(3, 2, 1)
    assert moon == moon

    refute moon == Moon.new(3, 2, 0)

    other = Moon.new(3, 2, 1)
    other.apply_gravity([Moon.new(4, 4, 4)])
    refute Moon.new(3, 2, 1) ==  other
  end
end
