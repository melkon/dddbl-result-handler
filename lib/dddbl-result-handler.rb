require 'rdbi'

class RDBI::Result::Driver::SINGLE_VALUE < RDBI::Result::Driver
  def format_single_row(raw)
    return nil if raw.empty?
    raw
  end

  def format_multiple_rows(raw_rows)
    return nil if raw_rows.empty?
    raw_rows.first
  end
end

class RDBI::Result::Driver::SINGLE < RDBI::Result::Driver
  def format_single_row(raw)
    return nil if raw.empty?

    single = {}

    (@result.schema.columns.map { |val| val[:name][:name] }).each do |column|
      single[column] = raw.shift
    end
    
    single
  end

  def format_multiple_rows(raw_rows)
    return nil if raw_rows.empty?
    format_single_row(raw_rows.first)
  end
end

# multiple empty rows are not supported (... yet?)
class RDBI::Result::Driver::NOT_NULL < RDBI::Result::Driver
  def format_single_row(raw)
    !raw.empty?
  end

  def format_multiple_rows(raw_rows)
    !raw_rows.empty?
  end
end
