require "minitest/autorun"
require_relative "checksum"

class ChecksumTest < Minitest::Test
  def test_checksum
    input = %w[
      abcdef
      bababc
      abbcde
      abcccd
      aabcdd
      abcdee
      ababab
    ]
    assert Checksum.new(input).sum(), 12
  end

  def test_diff
    input = %w[
      abcde
      prsta
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
    ]
    assert_equal "fgij", Checksum.new(input).diff()
  end
end