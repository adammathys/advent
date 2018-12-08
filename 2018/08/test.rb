require "minitest/autorun"
require_relative "license"

class LicenseTest < Minitest::Test
  INPUT = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

  def test_metasum
    assert_equal 138, License.new(INPUT).metasum
  end

  def test_value
    assert_equal 66, License.new(INPUT).value
  end
end
