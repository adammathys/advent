require "minitest/autorun"
require_relative "xmas"

class Test < Minitest::Test
  def setup
    @input = [
      35,
      20,
      15,
      25,
      47,
      40,
      62,
      55,
      65,
      95,
      102,
      117,
      150,
      182,
      127,
      219,
      299,
      277,
      309,
      576
    ]
  end

  def test_find_weakness
    xmas = Xmas.new(@input)
    assert_equal 127, xmas.find_weakness(5)
  end

  def test_encryption_weakness
    xmas = Xmas.new(@input)
    assert_equal 62, xmas.encryption_weakness(5)
  end
end
