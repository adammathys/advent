require "minitest/autorun"
require_relative "polymer"

class PolymerTest < Minitest::Test
  INPUT = "dabAcCaCBAcCcaDA"

  def test_react
    assert_equal "dabCBAcaDA", Polymer.new(INPUT).react()
  end

  def test_optimum
    assert_equal "daDA", Polymer.new(INPUT).optimum
  end
end
