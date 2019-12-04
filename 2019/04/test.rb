require "minitest/autorun"
require_relative "password"

class Test < Minitest::Test
  def test_valid
    assert Password.new("111111").valid?
    refute Password.new("223450").valid?
    refute Password.new("123789").valid?
  end

  def test_super_valid
    assert Password.new("112233").super_valid?
    refute Password.new("123444").super_valid?
    assert Password.new("111122").super_valid?
  end
end
