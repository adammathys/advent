require "minitest/autorun"
require_relative "bridge"

class BridgeTest < Minitest::Test
  def setup
    connections = <<-EOS
      0/2
      2/2
      2/3
      3/4
      3/5
      0/1
      10/1
      9/10
    EOS
    @bridge = Bridge.new(connections)
  end

  def test_strongest
    assert_equal 31, @bridge.strongest(0)
  end

  def test_longest
    assert_equal 19, @bridge.longest(0)[1]
  end
end
