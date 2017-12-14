class Solution
  def initialize(input)
    @input = input
    reset_firewall!
  end

  def severity
    firewall = reset_firewall!(delay: 0)
    (0..firewall.keys.max).sum do |depth|
      result =
        if firewall.dig(depth, :range)&.first
          (depth * firewall[depth][:range].size)
        else
          0
        end
      update_scanners!(firewall)
      result
    end
  end

  def safe_delay
    delay = 0
    delay += 1 while caught?(delay: delay)
    delay
  end

  private

  def caught?(delay:)
    firewall = reset_firewall!(delay: delay)
    (0..firewall.keys.max).each do |depth|
      return true if firewall.dig(depth, :range)&.first
      update_scanners!(firewall)
    end
    false
  end

  def update_scanners!(firewall)
    firewall.values.each do |hash|
      current = hash[:range].index(1)
      hash[:range][current] = nil
      current += hash[:direction]
      if current == 0 || current == (hash[:range].size - 1)
        hash[:direction] *= -1
      end
      hash[:range][current] = 1
    end
  end

  def parse(input)
    hash = {}
    input.lines.each do |line|
      depth, size = line.split(": ").map(&:to_i)
      hash[depth] = { direction: 1, range: Array.new(size) }
    end
    hash
  end

  def reset_firewall!(delay: 0)
    firewall = parse(@input)
    firewall.values.each do |hash|
      size = hash[:range].size
      hash[:range] = Array.new(size)
      offset = delay % (2 * size - 2)

      if offset == 0
        hash[:direction] = 1
      elsif offset == size - 1
        hash[:direction] = -1
      elsif offset >= size
        offset = (size - 1) + ((size - 1) - offset)
        hash[:direction] = -1
      end

      hash[:range][offset] = 1
    end
    firewall
  end
end
