require_relative "polymer"

base = File.read(__dir__ + "/input.txt").chomp

polymer = Polymer.new(base)

reacted = polymer.react()
puts "Size: #{reacted.length}"

best = polymer.optimum()
puts "Best: #{best.length}"
