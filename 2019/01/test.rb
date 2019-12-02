require "minitest/autorun"
require_relative "fuel"

class FuelTest < Minitest::Test
  def test_amount_required
    assert_equal 2, Fuel.amount_required(12)
    assert_equal 2, Fuel.amount_required(14)
    assert_equal 654, Fuel.amount_required(1969)
    assert_equal 33583, Fuel.amount_required(100756)
  end

  def test_recursive_required
    assert_equal 2, Fuel.recursive_required(14)
    assert_equal 966, Fuel.recursive_required(1969)
    assert_equal 50346, Fuel.recursive_required(100756)
  end
end
