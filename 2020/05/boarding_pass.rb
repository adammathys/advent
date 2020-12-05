require 'pry'

class BoardingPass
  def initialize(code)
    @code = code.strip
  end

  def seat_id
    @row ||= search(0, 127, @code[0..6].chars)
    @column ||= search(0, 7, @code[-3..].chars)

    (@row * 8) + @column
  end

  private

  def search(min, max, key)
    return min if key.empty?

    half = (min + max) / 2
    if %w(F L).include?(key.shift)
      search(min, half, key)
    else
      search(half + 1, max, key)
    end
  end
end
