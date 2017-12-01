require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_simple_part1
    assert Solution.part1("1122") == 3
  end

  def test_all_matches_part1
    assert Solution.part1("1111") == 4
  end

  def test_no_matches_part1
    assert Solution.part1("1234") == 0
  end

  def test_end_matches_part1
    assert Solution.part1("91212129") == 9
  end

  def test_simple_part2
    assert Solution.part2("1212") == 6
  end

  def test_no_matches_part2
    assert Solution.part2("1221") == 0
  end

  def test_one_match_part2
    assert Solution.part2("123425") == 4
  end

  def test_all_match_part2
    assert Solution.part2("123123") == 12
  end

  def test_complex_part2
    assert Solution.part2("12131415") == 4
  end
end
