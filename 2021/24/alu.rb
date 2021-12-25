class Alu
  def initialize(instructions)
    # The parts of the input that differ for us.
    # Line 4: div z [26,1]
    # Line 5: add x [val]
    # Line 15: add y [val]
    @inputs = instructions.each_slice(18).map {
      {
        d: _1[4].split.last.to_i,
        x: _1[5].split.last.to_i,
        y: _1[15].split.last.to_i
      }
    }
    @cache = { 0 => { min: 0, max: 0 } }
  end

  def max
    find_valid[:max]
  end

  def min
    find_valid[:min]
  end

  private

  def find_valid
    return @cache[0] if @cache[0][:max].to_s.length == @inputs.length

    @inputs.each do |inputs|
      # No modifying hashes in place. *Sigh*
      new_cache = build_cache
      @cache.each do |z, n|
        (1..9).each do |w|
          z1 = func(w, z, inputs)

          new_cache[z1][:min] = [new_cache[z1][:min], n[:min]*10+w].min
          new_cache[z1][:max] = [new_cache[z1][:max], n[:max]*10+w].max
        end
      end
      @cache = new_cache
    end

    @cache[0]
  end

  def build_cache
    Hash.new{ |h,k| h[k] = { min: 99_999_999_999_999, max: 0 } }
  end

  # Found by "decompilling" the instructions by hand.
  def func(w, z, inputs)
    if (z % 26 + inputs[:x]) != w
      z / inputs[:d] * 26 + w + inputs[:y]
    else
      z / inputs[:d]
    end
  end
end
