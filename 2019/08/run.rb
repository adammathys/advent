require_relative "image"
require "pry"

input = File.read("input.txt").chomp
image = Image.new(input)

puts image.checksum
image.print
