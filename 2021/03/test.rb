require "minitest/autorun"
require_relative "binary"

class BinaryTest < Minitest::Test
  def setup
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
    @binary = Binary.new(input)
  end

  def test_gamma
    assert_equal 22, @binary.gamma
  end

  def test_epsilon
    assert_equal 9, @binary.epsilon
  end

  def test_oxygen
    assert_equal 23, @binary.oxygen
  end

  def test_co2
    assert_equal 10, @binary.co2
  end
end
