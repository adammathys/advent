class Firewall
  def initialize(input)
    @firewall = input.lines.map do |line|
      line.split(": ").map(&:to_i)
    end.to_h
  end

  def severity
    @firewall.sum do |depth, range|
      caught?(depth, range) ? depth * range : 0
    end
  end

  def safe_delay
    delay = 0
    delay += 1 until safe?(delay: delay)
    delay
  end

  private

  def safe?(delay:)
    @firewall.none? do |depth, range|
      caught?(depth + delay, range)
    end
  end

  def caught?(depth, range)
    depth % (2 * (range - 1)) == 0
  end
end
