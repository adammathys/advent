require "minitest/autorun"
require_relative "expense_report"

class ExpenseReportTest < Minitest::Test
  def test_twenty_twenty
    report = ExpenseReport.new(
      %w[1721 979 366 299 675 1456]
    )
    assert_equal 514579, report.twenty_twenty
    assert_equal 241861950, report.twenty_twenty(3)
  end
end
