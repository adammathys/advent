require "minitest/autorun"
require_relative "probe"

class ProbeTest < Minitest::Test
  def setup
    @probe = Probe.new(x: (20..30), y: (-10..-5))
  end

  def test_max_y
    assert_equal 45, @probe.max_y
  end

  def test_count
    assert_equal 112, @probe.velocities.count
  end
end
