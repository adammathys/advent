require "minitest/autorun"
require_relative "probe"

class ProbeTest < Minitest::Test
  def setup
    input = File.read("test-input.txt").chomp
    @probe = Probe.new(input)
  end

  def test_count
    assert_equal 79, @probe.count
  end

  def test_farthest
    assert_equal 3621, @probe.farthest
  end
end
