require "minitest/autorun"
require_relative "transmission"

class TransmissionTest < Minitest::Test
  def test_1
    transmission = Transmission.new("12345678")
    assert_equal "48226158", transmission.process(1)
    assert_equal "34040438", transmission.process(2)
    assert_equal "03415518", transmission.process(3)
    assert_equal "01029498", transmission.process(4)
  end

  def test_2
    transmission = Transmission.new("80871224585914546619083218645595")
    assert_equal "24176176", transmission.process(100)
  end

  def test_3
    transmission = Transmission.new("19617804207202209144916044189917")
    assert_equal "73745418", transmission.process(100)
  end

  def test_4
    transmission = Transmission.new("69317163492948606335995924319873")
    assert_equal "52432133", transmission.process(100)
  end

  def test_5
    base = "03036732577212944063491565474664"
    transmission = Transmission.new(base * 10_000)
    assert_equal "84462026", transmission.process_with_offset
  end
end
