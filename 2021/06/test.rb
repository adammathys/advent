require "minitest/autorun"
require_relative "lanternfish"

class LanternfishTest < Minitest::Test
  def setup
    @fish = Lanternfish.new("3,4,3,1,2")
  end

  def test_count
    assert_equal 26, @fish.count(18)
    assert_equal 5934, @fish.count(80)
    assert_equal 26984457539, @fish.count(256)
  end
end
