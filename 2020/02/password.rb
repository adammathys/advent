class Password
  LegacyRule = Struct.new(:char, :range) do
    def valid?(password)
      range.cover?(password.count(char))
    end
  end

  NewRule = Struct.new(:char, :x, :y) do
    def valid?(password)
      (password[x-1] == char) ^ (password[y-1] == char)
    end
  end

  def initialize(raw)
    raw_rule, raw_text = raw.split(':')
    range, char = raw_rule.split(' ')
    x, y = range.split('-').map(&:to_i)

    @legacy_rule = LegacyRule.new(char.strip, x..y)
    @rule = NewRule.new(char.strip, x, y)
    @text = raw_text.strip
  end

  def legacy_valid?
    @legacy_rule.valid?(@text)
  end

  def valid?
    @rule.valid?(@text)
  end
end
