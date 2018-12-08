class License
  Node = Struct.new(:children, :metadata) do
    def metasum
      children.sum(&:metasum) + metadata.sum
    end

    def value
      if children.empty?
        metadata.sum
      else
        metadata.sum do |index|
          child = children[index - 1]
          child ? child.value : 0
        end
      end
    end
  end

  def initialize(input)
    @tree = parse(input.split(' ').map(&:to_i))
  end

  def metasum
    @tree.metasum
  end

  def value
    @tree.value
  end

  private

  def parse(input)
    children, metadata = input.shift(2)
    Node.new(
      children.times.map { parse(input) },
      input.shift(metadata)
    )
  end
end
