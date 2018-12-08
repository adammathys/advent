require_relative "license"

input = File.read(__dir__ + "/input.txt").chomp

license = License.new(input)
puts "Metasum: #{license.metasum}"
puts "Root value: #{license.value}"
