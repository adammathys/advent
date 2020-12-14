require_relative "program"

input = File.readlines("input.txt")
program = Program.new(input)

program.run!
puts "Memory: #{program.memory.sum}"

program.run!(version: 2)
puts "Memory (v2): #{program.memory.sum}"
