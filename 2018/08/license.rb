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
    @tree = parse(input.split(' ').map(&:to_i)).first
  end

  def metasum
    @tree.metasum
  end

  def value
    @tree.value
  end

  private

  def parse(input, index = 0)
    children = input[index]
    metadata = input[index + 1]
    index += 2

    node = Node.new([], [])

    children.times do
      child, index = parse(input, index)
      node.children << child
    end

    metadata.times do
      node.metadata << input[index]
      index += 1
    end

    [node, index]
  end
end
