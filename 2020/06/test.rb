require "minitest/autorun"
require_relative "group"

class GroupTest < Minitest::Test
  def test_count_any
    assert_equal 3, Group.new("abc").count_any
    assert_equal 3, Group.new("a\nb\nc").count_any
    assert_equal 3, Group.new("ab\nac").count_any
    assert_equal 1, Group.new("a\na\na\na").count_any
    assert_equal 1, Group.new("b").count_any
  end

  def test_count_all
    assert_equal 3, Group.new("abc").count_all
    assert_equal 0, Group.new("a\nb\nc").count_all
    assert_equal 1, Group.new("ab\nac").count_all
    assert_equal 1, Group.new("a\na\na\na").count_all
    assert_equal 1, Group.new("b").count_all
  end
end
