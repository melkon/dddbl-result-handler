$:.unshift(File.dirname(__FILE__))

require 'helper'

class TestSingleValue < Test::Unit::TestCase
  def setup
    @dbh = mock_connect
  end
  
  def teardown
    @dbh.disconnect
  end

  def test_01_single_value

    # single row, single value
    sth = mock_statement_with_results(@dbh, ['single_result'])

    single_value = sth.execute.fetch(:all, :SINGLE_VALUE)
    assert_equal('single_result', single_value)

    single_value = sth.execute.fetch(:first, :SINGLE_VALUE)
    assert_equal('single_result', single_value)

    single_value = sth.execute.fetch(:last, :SINGLE_VALUE)
    assert_equal('single_result', single_value)

    # single row, multiple values
    sth = mock_statement_with_results(@dbh, ['more_results', 'than_supported'])
   
    single_value = sth.execute.fetch(:all, :SINGLE_VALUE)
    assert_equal('more_results', single_value)
    
    single_value = sth.execute.fetch(:first, :SINGLE_VALUE)
    assert_equal('more_results', single_value)

    single_value = sth.execute.fetch(:last, :SINGLE_VALUE)
    assert_equal('than_supported', single_value)

    # single, empty row
    sth = mock_statement_with_results(@dbh, [])

    single_value = sth.execute.fetch(:all, :SINGLE_VALUE)
    assert_equal(nil, single_value)

    single_value = sth.execute.fetch(:first, :SINGLE_VALUE)
    assert_equal(nil, single_value)

    single_value = sth.execute.fetch(:last, :SINGLE_VALUE)
    assert_equal(nil, single_value)
  end

  def test_02_single 
    columns = ['column_1', 'column_2']

    sth = mock_result([['row_1_1', 'row_1_2'], ['row_2_1', 'row_2_2']], columns)
    single = sth.execute.fetch(:all, :SINGLE)
    assert_equal({ "column_1" => 'row_1_1', "column_2" => 'row_1_2' }, single)

    sth = mock_result([['row_1_1', 'row_1_2'], ['row_2_1', 'row_2_2']], columns)
    single = sth.execute.fetch(:first, :SINGLE)
    assert_equal({ "column_1" => 'row_1_1', "column_2" => 'row_1_2' }, single)

    sth = mock_result([['row_1_1', 'row_1_2'], ['row_2_1', 'row_2_2']], columns)
    single = sth.execute.fetch(:last, :SINGLE)
    assert_equal({ "column_1" => 'row_2_1', "column_2" => 'row_2_2' }, single)

    single = mock_result(nil, columns).execute.fetch(:all, :SINGLE)
    assert_equal(nil, single)

    single = mock_result(nil, columns).execute.fetch(:first, :SINGLE)
    assert_equal(nil, single)

    single = mock_result(nil, columns).execute.fetch(:last, :SINGLE)
    assert_equal(nil, single)
  end

  def test_03_not_null
    sth = mock_result([], ['column'])
    not_null = sth.execute.fetch(:all, :NOT_NULL)
    assert_equal(false, not_null)

    # single row, multiple results
    sth = mock_result([], ['column_1', 'column_2'])
    not_null = sth.execute.fetch(:all, :NOT_NULL)
    assert_equal(false, not_null)

    # single row, single result
    sth = mock_result(['value'], ['column'])
    not_null = sth.execute.fetch(:all, :NOT_NULL)
    assert_equal(true, not_null)

    # single row, multiple results
    sth = mock_result(['value_1', 'value_2'], ['column_1', 'column_2'])
    not_null = sth.execute.fetch(:all, :NOT_NULL)
    assert_equal(true, not_null)

    # multiple row, multiple results
    sth = mock_result([['value_1_1', 'value_1_2'], ['value_2_1', 'value_2_2']], ['column_1', 'column_2'])
    not_null = sth.execute.fetch(:all, :NOT_NULL)
    assert_equal(true, not_null)

  end
end
