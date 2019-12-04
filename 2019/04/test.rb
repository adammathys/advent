require "minitest/autorun"
require_relative "password"

class Test < Minitest::Test
  def test_valid
    assert Password.new("112233").valid?
    assert Password.new("111122").valid?

    refute Password.new("111111").valid?
    refute Password.new("223450").valid?
    refute Password.new("123789").valid?
    refute Password.new("123444").valid?
  end
end
