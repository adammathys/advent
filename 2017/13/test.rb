require "minitest/autorun"
require_relative "firewall"

class FirewallTest < Minitest::Test
  INPUT = <<~EOS
    0: 3
    1: 2
    4: 4
    6: 4
  EOS

  def test_severity
    assert_equal 24, Firewall.new(INPUT).severity
  end

  def test_safe_delay
    assert_equal 10, Firewall.new(INPUT).safe_delay
  end
end
