require "csv"

csv = CSV.read("chal-1-data.csv")

# Load data and create the lists

list_1 = []
list_2 = []

csv.each do |row|
  list_1 << row[0].to_i
  list_2 << row[1].to_i
end

tally = list_2.tally

sim_list = []

for item in list_1
  if tally.key?(item)
    sim_list << item * tally[item]
  else
    sim_list << 0
  end
end

p sim_list.sum
