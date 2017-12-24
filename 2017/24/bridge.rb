class Bridge
  def initialize(connections)
    @connections = connections.lines.map { |l| l.split("/").map(&:to_i) }
  end

  def strongest(start, used: [])
    conns = @connections - used
    possible = conns.select do |conn|
      conn[0] == start || conn[1] == start
    end

    return 0 if possible.empty?

    possible.map do |conn|
      other = (conn - [start])[0] || start
      strongest = strongest(other, used: used + [conn])
      conn.sum + (strongest || 0)
    end.max
  end

  def longest(start, length: 0, used: [])
    conns = @connections - used
    possible = conns.select do |conn|
      conn[0] == start || conn[1] == start
    end

    return [length, 0] if possible.empty?

    possible.map do |conn|
      other = (conn - [start])[0] || start
      l, s = longest(other, length: length + 1, used: used + [conn])
      [l, start + other + s]
    end.sort.last
  end
end
