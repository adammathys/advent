require "minitest/autorun"
require_relative "gameboy"

class GameboyTest < Minitest::Test
  def test_run
    @gameboy = Gameboy.new([
      %w(nop +0),
      %w(acc +1),
      %w(jmp +4),
      %w(acc +3),
      %w(jmp -3),
      %w(acc -99),
      %w(acc +1),
      %w(jmp -4),
      %w(acc +6)
    ])
    refute @gameboy.run
    assert_equal 1, @gameboy.index
    assert_equal 5, @gameboy.accumulator
  end

  def test_autocorrect
    @gameboy = Gameboy.new([
      %w(nop +0),
      %w(acc +1),
      %w(jmp +4),
      %w(acc +3),
      %w(jmp -3),
      %w(acc -99),
      %w(acc +1),
      %w(jmp -4),
      %w(acc +6)
    ])
    assert @gameboy.run(true)
    assert_equal 9, @gameboy.index
    assert_equal 8, @gameboy.accumulator
  end
end
