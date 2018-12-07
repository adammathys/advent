class Graph
  class Node
    attr_reader :name, :parents

    def initialize(name)
      @name = name
      @parents = []
    end

    def <=>(other)
      self.name <=> other
    end
  end

  def initialize
    @nodes = Set.new
  end

  def add(name, parent)
    node(name).parents << node(parent)
  end

  def pop(node)
    @nodes.delete(node)
    @nodes.each { |n| n.parents.delete(node) }
  end

  def parentless
    @nodes.select { |n| n.parents.empty? }
  end

  def size
    @nodes.size
  end

  private

  def node(name)
    node = @nodes.find { |n| n.name == name }
    unless node
      node = Node.new(name)
      @nodes << node
    end
    node
  end
end
