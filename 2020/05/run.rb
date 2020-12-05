require_relative "boarding_pass"

input = File.readlines("input.txt")

passes = input.map { |i| BoardingPass.new(i) }
seat_ids = passes.map(&:seat_id)

puts "Max Seat ID: #{seat_ids.max}"

sorted = seat_ids.sort
missing = ((sorted.min..sorted.max).to_a - sorted)[0]
puts "Missing Seat ID: #{missing}"
