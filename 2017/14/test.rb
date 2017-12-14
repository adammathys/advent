require "minitest/autorun"
require_relative "disk"

class SolutionTest < Minitest::Test
  def test_used
    assert_equal 8108, Disk.new("flqrgnkx").used
  end

  def test_regions
    assert_equal 1242, Disk.new("flqrgnkx").regions
  end
end
