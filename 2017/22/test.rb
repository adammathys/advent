require "minitest/autorun"
require_relative "virus"

class VirusTest < Minitest::Test
  def setup
    grid = <<-EOS
      ..#
      #..
      ...
    EOS
    @virus = Virus.new(grid)
  end

  def test_short_burst
    assert_equal 5, @virus.burst(7)
  end

  def test_medium_burst
    assert_equal 41, @virus.burst(70)
  end

  def test_long_burst
    assert_equal 5_587, @virus.burst(10_000)
  end
end
