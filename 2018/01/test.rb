require "minitest/autorun"
require_relative "frequency"

class FrequencyTest < Minitest::Test
  def test_all_additions
    input = %w[+1 +1 +1]
    assert Frequency.new(input).sum(), 3
  end

  def test_mixed
    input = %w[+1 +1 -2]
    assert Frequency.new(input).sum(), 0
  end

  def test_all_subtractions
    input = %w[-1 -2 -3]
    assert Frequency.new(input).sum(), -6
  end

  def test_simple_duplicate
    input = %w[+1 -1]
    assert Frequency.new(input).first_duplicate(), 0
  end

  def test_once_duplicate
    input = %w[+3 +3 +4 -2 -4]
    assert Frequency.new(input).first_duplicate(), 10
  end

  def test_medium_duplicate
    input = %w[-6 +3 +8 +5 -6]
    assert Frequency.new(input).first_duplicate(), 5
  end

  def test_large_duplicate
    input = %w[+7 +7 -2 -7 -4]
    assert Frequency.new(input).first_duplicate(), 14
  end
end