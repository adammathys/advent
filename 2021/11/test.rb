require "minitest/autorun"
require_relative "octopi"

class OctopiTest < Minitest::Test
  def setup
    input = [
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526"
    ]
    @octopi = Octopi.new(input)
  end

  def test_flashes
    assert_equal 204, @octopi.flashes(10)
    assert_equal 1656, @octopi.flashes(100)
  end

  def test_synced_flash
    assert_equal 195, @octopi.synced_flash
  end
end
