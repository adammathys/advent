require "minitest/autorun"
require_relative "weak"

class WeakTest < Minitest::Test
  def setup
    grid = <<-EOS
      ..#
      #..
      ...
    EOS
    @weak = Weak.new(grid)
  end

  def test_short_burst
    assert_equal 26, @weak.burst(100)
  end

  def test_long_burst
    assert_equal 2_511_944, @weak.burst(10_000_000)
  end
end
