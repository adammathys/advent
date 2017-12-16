require "minitest/autorun"
require_relative "sort"

class SortTest < Minitest::Test
  def test_spin
    assert_equal "eabcd", Sort.new(5, "s1").dance
  end

  def test_exchange
    assert_equal "abced", Sort.new(5, "x3/4").dance
  end

  def test_partner
    assert_equal "aecdb", Sort.new(5, "pe/b").dance
  end

  def test_dance
    assert_equal "baedc", Sort.new(5, "s1,x3/4,pe/b").dance
  end
end
