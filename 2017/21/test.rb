require "minitest/autorun"
require_relative "art"

class ArtTest < Minitest::Test
  def test_on
    rules = <<-EOS
      ../.# => ##./#../...
      .#./..#/### => #..#/..../..../#..#
    EOS
    @art = Art.new(rules)
    assert_equal 12, @art.on(2)
  end
end
