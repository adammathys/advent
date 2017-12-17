require "minitest/autorun"
require_relative "spinlock"

class SpinlockTest < Minitest::Test
  def test_happy
    assert_equal 638, Spinlock.new(3).happy
  end
end
