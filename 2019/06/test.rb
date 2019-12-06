require "minitest/autorun"
require_relative "orbit"

class OrbitTest < Minitest::Test
  def test_checksum
    assert_equal 42, Orbit.new(
      %w[COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L]
    ).checksum
  end

  def test_minimum_transfers
    assert_equal 4, Orbit.new(
      %w[COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L K)YOU I)SAN]
    ).minimum_transfers("YOU", "SAN")
  end
end
