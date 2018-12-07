class Elf
  attr_accessor :current_node, :ready_at

  def working?
    !current_node.nil?
  end

  def free?
    !working?
  end

  def ready?(time)
    ready_at == time
  end

  def reset
    @current_node = nil
    @ready_at = nil
  end
end
