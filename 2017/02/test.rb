require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_checksum
    input = <<-EOS
      5 1 9 5
      7 5 3
      2 4 6 8
    EOS
    assert Solution.firstStar(input) == 18
  end

  def test_division_checksum
    input = <<-EOS
      5 9 2 8
      9 4 7 3
      3 8 6 5
    EOS
    assert Solution.secondStar(input) == 9
  end
end
