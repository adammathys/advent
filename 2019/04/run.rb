require_relative "password"

range = 234208..765869

puts range.select { |x| Password.new(x).super_valid? }.count
