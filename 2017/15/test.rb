require "minitest/autorun"
require_relative "judge"

class JudgeTest < Minitest::Test
  def test_loose_matches
    assert_equal 588, Judge.new(65, 8921).loose_matches
  end

  def test_strict_matches
    assert_equal 309, Judge.new(65, 8921).strict_matches
  end
end
