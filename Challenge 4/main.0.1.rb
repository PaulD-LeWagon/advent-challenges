#!/usr/bin/env ruby

# Challenge 4
#
# Part 1:
# Count the occurences of the word XMAS in all directions/orientations
#
# Part 2:
# Count the occurences of the word MAS in the shape of an X
# e.g.
#
# M_M ... M_S ... S_S ... S_M
# _A_ ... _A_ ... _A_ ... _A_
# S_S ... M_S ... M_M ... S_M

the_matrix = []

def count_word(row)
  row.join.scan(/(MAS)/).size + row.join.scan(/(SAM)/).size
end

def print_captured(row)
  puts "[#{count_word row}] #{row.join.gsub(regex = /(MAS(AM)?|SAM(AS)?)/, "[\\1]")}"
end

def get_diagonal(two_d_array, x = 0, y = 0)
  len = two_d_array.length
  ret_array = []
  two_d_array.each_with_index do |row, i|
    if i + y >= len || i + x >= len
      next
    else
      ret_array << two_d_array[i + y][i + x]
    end
  end
  return ret_array
end

File.read("input.txt").each_line do |line|
  the_matrix << line.delete("\n").chars
  # p line.delete("\n").chars
end

puts "Rows: #{the_matrix.size}"
sum = 0
# # Left/Right
# the_matrix.each do |row|
#   # print_captured row
#   sum += count_word(row)
# end
# puts "Current count after checking left/right axis is: #{sum}."

# # Up/Down
# the_matrix.transpose.each do |row|
#   # print_captured row
#   sum += count_word(row)
# end
# puts "Current count after checking up/down axis is: #{sum}."

# Left to right diagonal
the_matrix.first.each_with_index do |row, i|
  sum += count_word(get_diagonal(the_matrix, i))
end
for i in (1..the_matrix.first.length)
  sum += count_word(get_diagonal(the_matrix, 0, i))
end

# Right to left diagonal
rev_matrix = []
the_matrix.each do |row|
  rev_matrix << row.reverse
end
rev_matrix.first.each_with_index do |row, i|
  sum += count_word(get_diagonal(rev_matrix, i))
end
for i in (1..rev_matrix.first.length)
  sum += count_word(get_diagonal(rev_matrix, 0, i))
end

puts "Total number of X-MASes detected: [#{sum / 2}]"

# # Left to right diagonal
# the_matrix.length.times do |i|
#   row = (0...the_matrix.length).collect { |i| the_matrix[i][i] }
#   # print_captured row
#   sum += count_word(row)
#   (the_matrix.length).times do |i|
#     the_matrix[i].rotate!(1)
#   end
# end
# puts "Current count after checking left-to-right diagonal is: #{sum}."

# # Right to left diagonal
# the_matrix.length.times do |i|
#   row = (0...the_matrix.length).collect { |i| the_matrix[i][(the_matrix.length - 1) - i] }
#   # print_captured row
#   sum += count_word(row)
#   (the_matrix.length).times do |i|
#     the_matrix[i].rotate!(1)
#   end
# end
