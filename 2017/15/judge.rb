class Judge
  BIT_MASK = 0xffff

  A_FACTOR = 16_807
  B_FACTOR = 48_271

  def initialize(a, b)
    @a_start = a
    @b_start = b
  end

  def loose_matches
    a = enumerator(@a_start, A_FACTOR)
    b = enumerator(@b_start, B_FACTOR)
    Array.new(40_000_000).sum do
      (a.next & BIT_MASK) == (b.next & BIT_MASK) ? 1 : 0
    end
  end

  def strict_matches
    a = enumerator(@a_start, A_FACTOR, criteria: 3)
    b = enumerator(@b_start, B_FACTOR, criteria: 7)
    Array.new(5_000_000).sum do
      (a.next & BIT_MASK) == (b.next & BIT_MASK) ? 1 : 0
    end
  end

  private

  def enumerator(start, factor, criteria: 0)
    Enumerator.new do |y|
      x = start
      loop do
        x = (x * factor) % 2147483647
        y << x if x & criteria == 0
      end
    end
  end
end
