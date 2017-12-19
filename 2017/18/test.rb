require "minitest/autorun"
require_relative "duet"

class DuetTest < Minitest::Test
  INPUT = <<~EOS
    set a 1
    add a 2
    mul a a
    mod a 5
    snd a
    set a 0
    rcv a
    jgz a -1
    set a 1
    jgz a -2
  EOS

  def test_first_recovered
    assert_equal 4, Duet.new(INPUT).first_recovered
  end
end
