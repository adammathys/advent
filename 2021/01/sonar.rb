class Sonar
  def initialize(depths)
    @depths = depths
  end

  def increases(window = 1)
    @depths.each_cons(window).map(&:sum).each_cons(2).count{_1<_2}
  end
end
