require_relative "codes"

input = File.readlines("input.txt").map(&:chomp)

Codes.new(input).run
