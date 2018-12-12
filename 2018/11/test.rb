require "minitest/autorun"
require_relative "power_grid"

class PowerGridTest < Minitest::Test
  def test_max_power
    cell = PowerGrid.new(serial_number: 18).max_power
    assert_equal [33, 45], cell.position
    assert_equal 29, cell.power
  end

  def test_variable_max_power
    size, cell = PowerGrid.new(serial_number: 18).variable_max_power
    assert_equal 16, size
    assert_equal [90, 269], cell.position
    assert_equal 113, cell.power
  end
end
