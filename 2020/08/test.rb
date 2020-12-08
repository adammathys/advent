require "minitest/autorun"
require_relative "gameboy"

class GameboyTest < Minitest::Test
  def setup
    @input = [
      %w(nop +0),
      %w(acc +1),
      %w(jmp +4),
      %w(acc +3),
      %w(jmp -3),
      %w(acc -99),
      %w(acc +1),
      %w(jmp -4),
      %w(acc +6)
    ]
  end

  def test_run
    gameboy = Gameboy.new(@input)
    refute gameboy.run
    assert_equal 1, gameboy.idx
    assert_equal 5, gameboy.acc
  end

  def test_autocorrect
    gameboy = Gameboy.new(@input)
    assert gameboy.run(true)
    assert_equal 9, gameboy.idx
    assert_equal 8, gameboy.acc
  end
end
