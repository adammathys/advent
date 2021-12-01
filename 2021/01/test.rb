require "minitest/autorun"
require_relative "sonar"

class SonarTest < Minitest::Test
  def setup
    @sonar = Sonar.new([
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263
    ])
  end

  def test_increases
    assert_equal 7, @sonar.increases
  end

  def test_increases_three_window
    assert_equal 5, @sonar.increases(3)
  end
end
