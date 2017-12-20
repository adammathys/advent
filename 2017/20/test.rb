require "minitest/autorun"
require_relative "swarm"

class SwarmTest < Minitest::Test
  def test_closest
    @swarm = Swarm.new(<<~EOS)
      p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
      p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
    EOS
    assert_equal 1, @swarm.closest
  end

  def test_collide
    @swarm = Swarm.new(<<~EOS)
      p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
      p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
      p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
      p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
    EOS
    assert_equal 1, @swarm.collide
  end
end
