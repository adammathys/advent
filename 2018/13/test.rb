require "minitest/autorun"
require_relative "mine_carts"

class MineCartsTest < Minitest::Test
  def test_first_crash
    input = [
      '/->-\ ',
      '|   |  /----\ ',
      '| /-+--+-\  | ',
      '| | |  | v  | ',
      '\-+-/  \-+--/ ',
      '  \------/'
    ]
    carts = MineCarts.new(input)
    assert_equal [7,3], carts.first_crash.to_a
  end

  def test_last_standing
    input = [
      '/>-<\   ',
      '|   |   ',
      '| /<+-\ ',
      '| | | v ',
      '\>+</ | ',
      '  |   ^ ',
      '  \<->/ '
    ]
    carts = MineCarts.new(input)
    assert_equal [6,4], carts.last_standing.to_a
  end
end
