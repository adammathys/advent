require "minitest/autorun"
require_relative "program"

class ProgramTest < Minitest::Test
  def test_version_1
    program = Program.new([
      "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
      "mem[8] = 11",
      "mem[7] = 101",
      "mem[8] = 0"
    ])
    program.run!
    assert_equal 165, program.memory.sum
  end

  def test_version_2
    program = Program.new([
      "mask = 000000000000000000000000000000X1001X",
      "mem[42] = 100",
      "mask = 00000000000000000000000000000000X0XX",
      "mem[26] = 1"
    ])
    program.run!(version: 2)
    assert_equal 208, program.memory.sum
  end
end
