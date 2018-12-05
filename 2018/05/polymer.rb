class Polymer
  def initialize(base)
    @base = base
  end

  def optimum
    ('a'..'z').flat_map do |char|
      react(@base.gsub(/#{char}/i, ''))
    end.min_by(&:length)
  end

  def react(base = @base)
    index = 0
    reacted = base.chars

    until index >= reacted.length
      a = reacted[index]
      b = reacted[index + 1]

      if a != b && a.casecmp?(b)
        2.times { reacted.delete_at(index) }
        index -= 1
      else
        index += 1
      end
    end

    reacted.join
  end
end
