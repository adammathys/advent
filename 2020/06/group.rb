class Group
  def initialize(info)
    @forms = info.split("\n").map{ |i| Set.new(i.chars) }
  end

  def count_any
    @forms.reduce(&:|).length
  end

  def count_all
    @forms.reduce(&:&).length
  end
end
