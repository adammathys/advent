require "minitest/autorun"
require_relative "password"

class PasswordTest < Minitest::Test
  def test_legacy_valid
    assert Password.new("1-3 a: abcde").legacy_valid?
    assert Password.new("2-9 c: ccccccccc").legacy_valid?
    refute Password.new("1-3 b: cdefg").legacy_valid?
  end

  def test_valid
    assert Password.new("1-3 a: abcde").valid?
    refute Password.new("2-9 c: ccccccccc").valid?
    refute Password.new("1-3 b: cdefg").valid?
  end
end
