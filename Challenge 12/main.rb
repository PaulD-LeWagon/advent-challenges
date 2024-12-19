require "csv"

csv = CSV.read("test-data.csv")

raw_matrix = []

tally_hash = {}

csv.each do |row|
  the_matrix << row[0].chars
end

regions = []
# region
# { type: "A", area: 1, perimeter: 4, price: area * perimeter } ???

# Do we need to deal with each region rather than parse a line at a time?

# (0..raw_matrix.length - 1).each do |i|
#   row = raw_matrix[i].chars
#   (0..row.length - 1).each do |j|
#     plot = row[j]
#     area = 1
#     perimeter = 0

#     if j - 1 >= 0 && row[j - 1] != plot
#       # We've found a boundary (perimeter)
#       perimeter += 1
#     elsif j - 1 < 0
#       # Garden edge
#       perimeter += 1
#     end

#     if i - 1 >= 0 && raw_matrix[i - 1].chars[j] != plot
#       # We've found a boundary (perimeter)
#       perimeter += 1
#     elsif i - 1 < 0
#       # Garden edge
#       perimeter += 1
#     end

#     if j + 1 <= row.length - 1 && row[j + 1] != plot
#       # We've found a boundary (perimeter)
#       perimeter += 1
#     elsif j + 1 >= row.length
#       # Garden edge
#       perimeter += 1
#     end

#     if i + 1 < raw_matrix.length && raw_matrix[i + 1].chars[j] != plot
#       # We've found a boundary (perimeter)
#       perimeter += 1
#     elsif i + 1 >= raw_matrix.length
#       # Garden edge
#       perimeter += 1
#     end

#     if !tally_hash.key?(plot)
#       tally_hash[plot] = { area: area, perimeter: perimeter }
#     else
#       th = tally_hash[plot]
#       th[:area] += area
#       th[:perimeter] += perimeter
#     end
#   end
# end

# for (key, val) in tally_hash
#   tally_hash[key][:price] = val[:area] * val[:perimeter]
# end

# tally_hash.each do |(key, val)|
#   p "#{key} = { a: #{val[:area]}, p: #{val[:perimeter]}, $#{val[:price]} }"
# end

# p tally_hash.sum { |(key, item)| item[:price] }
