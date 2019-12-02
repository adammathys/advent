require_relative "intcode"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

desired_output = 19690720

(0..99).each do |noun|
  (0..99).each do |verb|
    result = Intcode.new(state).run(noun, verb)
    if result[0] == desired_output
      puts "noun=#{noun} verb=#{verb}"
      puts (noun * 100) + verb
      exit
    end
  end
end
