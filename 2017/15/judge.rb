class Judge
  # 16 ones in binary
  BIT_MASK = 65_535

  A_FACTOR = 16_807
  B_FACTOR = 48_271

  def initialize(a, b)
    @a_start = a
    @b_start = b
  end

  def loose_matches
    a = enumerator(@a_start, A_FACTOR)
    b = enumerator(@b_start, B_FACTOR)
    count = 0
    40_000_000.times do
      count += 1 if (a.next & BIT_MASK) == (b.next & BIT_MASK)
    end
    count
  end

  def strict_matches
    a = enumerator(@a_start, A_FACTOR, strict: 4)
    b = enumerator(@b_start, B_FACTOR, strict: 8)
    count = 0
    5_000_000.times do
      count += 1 if (a.next & BIT_MASK) == (b.next & BIT_MASK)
    end
    count
  end

  private

  def enumerator(start, factor, strict: false)
    Enumerator.new do |y|
      x = start
      loop do
        x = (x * factor) % 2147483647
        if strict
          y << x if (x % strict == 0)
        else
          y << x
        end
      end
    end
  end
end
