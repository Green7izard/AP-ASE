# Assignment Ruby Unit Test
# Bas van Summeren<BasVanSummeren@hotmail.com>

require_relative "day3"
require "test/unit"

class TestDay3 < Test::Unit::TestCase

  #Basic test to see if the csvrow works
  def test_csvrow
    headers = ["zero", "one", "two"]
    values = ["TEST", "TEST2", "TEST3"]
    csvrow = CsvRow.new(headers, values)
    assert_equal(values[0], csvrow.zero)
    assert_equal(values[1], csvrow.one)
    assert_equal(values[2], csvrow.two)
  end

  #Test to see the error that comes from calling unkown values
  def test_csvrow_nonexisting
    headers = ["zero", "one", "two"]
    values = ["TEST", "TEST2", "TEST3"]
    csvrow = CsvRow.new(headers, values)
    assert_raise(NoMethodError) { csvrow.test }
  end

end