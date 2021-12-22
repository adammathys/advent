require "minitest/autorun"
require_relative "quantum"

class QuantumTest < Minitest::Test
  def setup
    @game = Quantum.new
  end

  def test_simulate
    assert_equal [
      444_356_092_776_315,
      341_960_390_180_808
    ], @game.simulate(4, 8)
  end
end
