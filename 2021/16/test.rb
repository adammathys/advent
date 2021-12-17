require "minitest/autorun"
require_relative "packet"

class PacketTest < Minitest::Test
  def test_version_sum
    assert_equal 16, Packet.from_hex("8A004A801A8002F478").version_sum
    assert_equal 12, Packet.from_hex("620080001611562C8802118E34").version_sum
    assert_equal 23, Packet.from_hex("C0015000016115A2E0802F182340").version_sum
    assert_equal 31, Packet.from_hex("A0016C880162017C3686B18A3D4780").version_sum
  end

  def test_value
    assert_equal 3, Packet.from_hex("C200B40A82").value
    assert_equal 54, Packet.from_hex("04005AC33890").value
    assert_equal 7, Packet.from_hex("880086C3E88112").value
    assert_equal 9, Packet.from_hex("CE00C43D881120").value
    assert_equal 1, Packet.from_hex("D8005AC2A8F0").value
    assert_equal 0, Packet.from_hex("F600BC2D8F").value
    assert_equal 0, Packet.from_hex("9C005AC2F8F0").value
    assert_equal 1, Packet.from_hex("9C0141080250320F1802104A08").value
  end
end
