require "minitest/autorun"
require_relative "fabric"

class FabricTest < Minitest::Test
  def test_overlap
    input = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]
    assert_equal 4, Fabric.new(input, size: 8).overlap()
  end

  def test_best
    input = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]
    assert_equal 3, Fabric.new(input, size: 8).best()
  end
end
