require_relative "checksum"

file = File.readlines(__dir__ + "/input.txt").map(&:chomp)

checksum = Checksum.new(file)
puts "Checksum: #{checksum.sum()}"
puts "Diff: #{checksum.diff()}"