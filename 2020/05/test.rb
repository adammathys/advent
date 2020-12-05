require "minitest/autorun"
require_relative "boarding_pass"

class Test < Minitest::Test
  def test_seat_id
    assert_equal 357, BoardingPass.new("FBFBBFFRLR").seat_id
    assert_equal 567, BoardingPass.new("BFFFBBFRRR").seat_id
    assert_equal 119, BoardingPass.new("FFFBBBFRRR").seat_id
    assert_equal 820, BoardingPass.new("BBFFBBFRLL").seat_id
  end
end
