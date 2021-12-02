class Sub
  def self.move(movements)
    position = [0, 0, 0]

    movements.each do
      direction, amount = _1.split
      amount = amount.to_i
      case direction
      when "forward"
        position[0] += amount
        position[2] += position[1] * amount
      when "down"
        position[1] += amount
      when "up"
        position[1] -= amount
      end
    end

    position
  end
end
