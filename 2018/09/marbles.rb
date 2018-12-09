class Marbles
  Player = Struct.new(:score)

  Node = Struct.new(:value, :prev, :next) do
    def append(value)
      Node.new(value, self, self.next).tap do |node|
        self.next.prev = node
        self.next = node
      end
    end

    def remove
      self.next.prev = self.prev
      self.prev.next = self.next
      self.next
    end
  end

  attr_reader :players, :circle
  attr_accessor :current

  def initialize(players:, rounds:)
    @players = Array.new(players) { Player.new(0) }
    @current = Node.new(0).tap do |node|
      node.next = node
      node.prev = node
    end

    1.upto(rounds) { |marble| round(marble) }
  end

  def high_score
    players.map(&:score).max
  end

  private

  def round(marble)
    if marble % 23 == 0
      player = players[(marble - 1) % players.size]
      7.times { self.current = current.prev }
      player.score += marble + current.value
      self.current = current.remove
    else
      self.current = current.next.append(marble)
    end
  end
end
