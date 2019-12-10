require_relative "intcode"
require "pry"

samples = [
  [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99],
  [1102,34915192,34915192,7,4,7,99,0],
  [104,1125899906842624,99]
]

samples.each do |sample|
  puts "---"
  puts "Running program: '#{sample.join(",")}'"
  code = Intcode.new(sample, 0)

  output = []

  until (r = code.run)[1]
    output << r[0]
  end

  print output.join(",")
  print "\n"
end

