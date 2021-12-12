require "minitest/autorun"
require_relative "pathing"

class PathingTest < Minitest::Test
  def test_paths_simple
    pathing = Pathing.new([
      "start-A",
      "start-b",
      "A-c",
      "A-b",
      "b-d",
      "A-end",
      "b-end"
    ])
    assert_equal 10, pathing.paths
    assert_equal 36, pathing.paths(true)
  end

  def test_paths_intermediate
    pathing = Pathing.new([
      "dc-end",
      "HN-start",
      "start-kj",
      "dc-start",
      "dc-HN",
      "LN-dc",
      "HN-end",
      "kj-sa",
      "kj-HN",
      "kj-dc"
    ])
    assert_equal 19, pathing.paths
    assert_equal 103, pathing.paths(true)
  end

  def test_paths_complex
    pathing = Pathing.new([
      "fs-end",
      "he-DX",
      "fs-he",
      "start-DX",
      "pj-DX",
      "end-zg",
      "zg-sl",
      "zg-pj",
      "pj-he",
      "RW-he",
      "fs-DX",
      "pj-RW",
      "zg-RW",
      "start-pj",
      "he-WI",
      "zg-he",
      "pj-fs",
      "start-RW"
    ])
    assert_equal 226, pathing.paths
    assert_equal 3509, pathing.paths(true)
  end
end
