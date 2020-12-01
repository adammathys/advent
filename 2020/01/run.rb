require_relative "expense_report"

input = File.readlines("input.txt")

report = ExpenseReport.new(input)
puts "2020 (2): #{report.twenty_twenty}"
puts "2020 (3): #{report.twenty_twenty(3)}"
