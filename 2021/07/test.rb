require "minitest/autorun"
require_relative "crabs"

class CrabsTest < Minitest::Test
  def setup
    @crabs = Crabs.new("16,1,2,0,4,2,7,1,2,14")
  end

  def test_min
    assert_equal 37, @crabs.min
  end

  def test_non_constant_min
    assert_equal 168, @crabs.min(false)
  end
end
