class Transmission
  BASE = [0, 1, 0, -1]

  def initialize(signal)
    @signal = signal
  end

  def process(n = 1)
    signal = @signal.chars.map(&:to_i)

    n.times do
      signal.each_index do |i|
        pattern = BASE.flat_map { |k| [k] * (i + 1) }
        values = signal.map.with_index do |k, j|
          k * pattern[(j + 1) % pattern.length]
        end
        signal[i] = values.sum.abs % 10
      end
    end

    signal[0..7].join
  end

  def process_with_offset
    offset = @signal[0..6].to_i

    # Don't care about the numbers before offset, their pattern entry would be
    # 0 for any of the numbers we care about calculating.
    signal = @signal[offset..-1].chars.map(&:to_i)

    100.times do
      # Pattern for each will be many 0s followed by 1s. As such, we can
      # simplify the calculation by using a running sum. (By starting at the
      # end and working our way to the start of the list.)
      (signal.length - 2).downto(0) do |i|
        signal[i] = (signal[i] + signal[i + 1]) % 10
      end
    end

    signal[0..7].join
  end
end
