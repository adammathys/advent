class Packet
  attr_reader :subpackets

  def self.from_hex(value)
    self.new(
      value.chars.map{ _1.hex.to_s(2).rjust(4, ?0) }.join
    )
  end

  def initialize(bits)
    @bits = bits
    @subpackets = []

    parse!
  end

  def version_sum
    version + @subpackets.sum(&:version_sum)
  end

  def value
    case type_id
    when 0
      @subpackets.sum(&:value)
    when 1
      @subpackets.map(&:value).reduce(:*)
    when 2
      @subpackets.map(&:value).min
    when 3
      @subpackets.map(&:value).max
    when 4
      @value
    when 5
      @subpackets[0] > @subpackets[1] ? 1 : 0
    when 6
      @subpackets[0] < @subpackets[1] ? 1 : 0
    when 7
      @subpackets[0] == @subpackets[1] ? 1 : 0
    end
  end

  def extra
    @bits[@last_bit..-1]
  end

  def <(other)
    value < other.value
  end

  def >(other)
    value > other.value
  end

  def ==(other)
    value == other.value
  end

  private

  def parse!
    if type_id == 4
      parse_literal
    else
      parse_operator
    end
  end

  def parse_literal
    value = ""
    @bits[6..-1].chars.each_slice(5).with_index { |bits, idx|
      value << bits[1..-1].join
      if bits[0] == "0"
        @last_bit = 5 * (idx + 1) + 6
        break
      end
    }
    @value = value.to_i(2)
  end

  def parse_operator
    case length_type_id
    when "0"
      num_bits = @bits[7...22].to_i(2)
      @last_bit = 22 + num_bits

      new_packet = Packet.new(@bits[22...@last_bit])
      @subpackets << new_packet

      until new_packet.extra.empty?
        new_packet = Packet.new(new_packet.extra)
        @subpackets << new_packet
      end
    when "1"
      num_packets = @bits[7...18].to_i(2)

      new_packet = Packet.new(@bits[18..-1])
      @subpackets << new_packet

      (num_packets - 1).times do
        new_packet = Packet.new(new_packet.extra)
        @subpackets << new_packet
      end

      @last_bit = @bits.length - new_packet.extra.length
    end
  end

  def version
    @bits[0...3].to_i(2)
  end

  def type_id
    @bits[3...6].to_i(2)
  end

  def length_type_id
    @bits[6]
  end
end
