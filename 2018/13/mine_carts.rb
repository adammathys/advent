class MineCarts
  Vector = Struct.new(:x, :y) do
    def to_a
      [x, y]
    end
  end

  class Cart
    attr_accessor :position, :direction, :next_turn, :crashed

    def initialize(position, direction)
      @position = position
      @direction = direction
      @next_turn = :left
      @crashed = false
    end

    def move
      position.x += direction.x
      position.y += direction.y
      position
    end

    def crash?(other)
      position == other.position
    end

    def <=>(other)
      if position.y < other.position.y
        -1
      elsif position.y > other.position.y
        1
      else
        position.x <=> other.position.x
      end
    end
  end

  def initialize(input)
    @carts = []
    @grid = input.map.with_index do |line, y|
      line.chars.map.with_index do |char, x|
        case char
        when ?<
          @carts << Cart.new(Vector.new(x, y), Vector.new(-1, 0))
          ?-
        when ?>
          @carts << Cart.new(Vector.new(x, y), Vector.new(1, 0))
          ?-
        when ?^
          @carts << Cart.new(Vector.new(x, y), Vector.new(0, -1))
          ?|
        when ?v
          @carts << Cart.new(Vector.new(x, y), Vector.new(0, 1))
          ?|
        else
          char
        end
      end
    end
  end

  def first_crash
    tick while crashed_carts.length < 1
    crashed_carts.first.position
  end

  def last_standing
    tick while active_carts.length > 1
    active_carts.first.position
  end

  private

  def active_carts
    @carts.reject(&:crashed)
  end

  def crashed_carts
    @carts.select(&:crashed)
  end

  def tick
    active_carts.sort.each do |cart|
      cart.move

      active_carts.each do |other|
        if cart != other && cart.crash?(other)
          cart.crashed = true
          other.crashed = true
        end
      end

      case @grid[cart.position.y][cart.position.x]
      when ?/
        cart.direction = Vector.new(
          cart.direction.y * -1,
          cart.direction.x * -1
        )
      when ?\\
        cart.direction = Vector.new(
          cart.direction.y,
          cart.direction.x
        )
      when ?+
        case cart.next_turn
        when :left
          cart.direction = Vector.new(
            cart.direction.y,
            cart.direction.x * -1
          )
          cart.next_turn = :straight
        when :straight
          cart.next_turn = :right
        when :right
          cart.direction = Vector.new(
            cart.direction.y * -1,
            cart.direction.x
          )
          cart.next_turn = :left
        end
      end
    end
  end
end
