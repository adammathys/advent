require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_simple_part1
    assert Solution.("1122") == 3
  end

  def test_all_matches_part1
    assert Solution.("1111") == 4
  end

  def test_no_matches_part1
    assert Solution.("1234") == 0
  end

  def test_end_matches_part1
    assert Solution.("91212129") == 9
  end

  def test_simple_part2
    assert Solution.("1212", 2) == 6
  end

  def test_no_matches_part2
    assert Solution.("1221", 2) == 0
  end

  def test_one_match_part2
    assert Solution.("123425", 3) == 4
  end

  def test_all_match_part2
    assert Solution.("123123", 3) == 12
  end

  def test_complex_part2
    assert Solution.("12131415", 4) == 4
  end
end
