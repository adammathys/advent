require "minitest/autorun"
require_relative "schedule"

class ScheduleTest < Minitest::Test
  def test_earliest
    schedule = Schedule.new(["939", "7,13,x,x,59,x,31,19"])
    assert_equal 295, schedule.earliest
  end

  def test_gold_coin
    assert_equal 3417, Schedule.new(["", "17,x,13,19"]).gold_coin
    assert_equal 1068781, Schedule.new(["", "7,13,x,x,59,x,31,19"]).gold_coin
    assert_equal 754018, Schedule.new(["", "67,7,59,61"]).gold_coin
    assert_equal 779210, Schedule.new(["", "67,x,7,59,61"]).gold_coin
    assert_equal 1261476, Schedule.new(["", "67,7,x,59,61"]).gold_coin
    assert_equal 1202161486, Schedule.new(["", "1789,37,47,1889"]).gold_coin
  end
end
