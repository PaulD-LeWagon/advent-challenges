require "csv"

csv = CSV.read("chal-1-data.csv")

# Load data and create the lists

list_1 = []
list_2 = []

csv.each do |row|
  list_1 << row[0].to_i
  list_2 << row[1].to_i
end

list_1.sort!
list_2.sort!

# Find the differences

uber_list = []

(0..list_1.length - 1).each do |i|
  uber_list << [list_1[i], list_2[i], (list_1[i] - list_2[i]).abs]
end

sum = 0
for item in uber_list
  puts "#{item[0]} #{item[1]} : #{item[2]}"
  sum += item[2]
end
p sum

p uber_list.sum { |item| item[2] }
