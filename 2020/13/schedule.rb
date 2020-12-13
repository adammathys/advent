class Schedule
  def initialize(input)
    @time = input[0].to_i
    @bus_ids = input[1].strip.split(",").map { |id|
      id == "x" ? nil : id.to_i
    }
  end

  def earliest
    @bus_ids.map { |id|
      [id, (@time * -1) % id] if id
    }.compact.min_by(&:last).reduce(&:*)
  end

  def gold_coin
    map = @bus_ids.map.with_index { |id, idx|
      [id - idx, id] if id
    }.compact
    chinese_remainder(map)
  end

  private

  # Based on: https://rosettacode.org/wiki/Chinese_remainder_theorem#C.23
  def chinese_remainder(map)
    max = map.map(&:last).reduce(&:*)
    sum = map.sum{ |r, mod|
      p = max / mod
      r * modinv(p, mod) * p
    }
    sum % max
  end

  def modinv(a, b)
    return 1 if b == 1
    b0, x0, x1 = b, 0, 1
    while a > 1
      q, r = a.divmod(b)
      a, b = b, r
      x1, x0 = x0, x1 - q * x0
    end
    x1 += b0 if x1 < 0
    x1
  end
end
