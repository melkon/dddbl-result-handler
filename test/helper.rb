$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# this is sooo wrong and is actually not gonna work properly
begin
  require 'bundler/setup'
rescue LoadError ; end

require 'test/unit'

require 'rdbi'
require 'rdbi/driver/mock'

require 'dddbl-result-handler'

class Test::Unit::TestCase
  def mock_connect
    RDBI.connect(:Mock, :username => 'foo', :password => 'bar')
  end

  def mock_statement_with_results(dbh, results)
    sth = dbh.prepare("some statement")
    sth.result = results
    sth
  end

  def mock_schema(columns)
    schema = RDBI::Schema.new([],[], nil)
    columns.each { |name| schema.columns << RDBI::Column.new(:name => name) }
    schema
  end

  def mock_result(results, columns)
    sth = mock_statement_with_results(@dbh, results)
    sth.set_schema = mock_schema(columns)
    sth
  end
end
