require "csv"

the_matrix = []
valid_reports = []

def is_valid_order?(row)
  row.each_cons(2).all? { |a, b| a <= b } || row.each_cons(2).all? { |a, b| a >= b }
end

def is_within_range?(row)
  row.each_cons(2).all? do |a, b|
    (a - b).abs in 1..3
  end
end

def validate_report?(row)
  is_valid_order?(row) && is_within_range?(row)
end

CSV.read("test-data.csv").each do |row|
  the_matrix << row.first.split(" ").map(&:to_i) if row.first != ""
end

the_matrix.each do |row|
  if validate_report?(row)
    valid_reports << row
  else # Initiate the Problem Dampener technique
    # Clone the row/report
    tmp_row = row.dup
    # Loop for the length of row/report
    for n in 0..tmp_row.length - 1
      # Remove the nth element and revalidate the report
      tmp_row.delete_at(n)
      # Now will it validate?
      if validate_report?(tmp_row)
        # If it does, add it to the valid reports
        valid_reports << row
        # And break out of the loop
        break
      end
      # Otherwise, reinstate the original row/report
      # so we can remove the next nth element
      tmp_row = row.dup
    end
  end
end

puts "#{"-" * 27}"
puts "Total reports: #{the_matrix.length}"
puts "#{"-" * 27}"
puts "Valid reports: #{valid_reports.length}"
puts "#{"-" * 27}"
puts "Invalid reports: #{the_matrix.length - valid_reports.length}"
puts "#{"-" * 27}"
