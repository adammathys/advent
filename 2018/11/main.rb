require_relative "power_grid"

grid =  PowerGrid.new(serial_number: 9810)
puts "Most power: #{grid.max_power}"
puts "Best possible: #{grid.variable_max_power}"
