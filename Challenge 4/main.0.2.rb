#!/usr/bin/env ruby

# Challenge 4
#
# Part 2:
# Count the occurences of the word MAS in the shape of an X
# e.g.
#
# M_M ... M_S ... S_S ... S_M
# _A_ ... _A_ ... _A_ ... _A_
# S_S ... M_S ... M_M ... S_M

the_matrix = []

File.read("input.txt").each_line do |line|
  the_matrix << line.delete("\n").chars
  # p line.delete("\n").chars
end

puts "Rows: #{the_matrix.size}"
sum = 0

def check_x(array, x, y)
  reg_ms = /(MAS|SAM)/
  cr = array[x][y] # Center, should be A

  x -= 1
  y -= 1

  tl = array[x][y] # Top left
  tr = array[x + 2][y] # Top right
  bl = array[x][y + 2] # Bottom left
  br = array[x + 2][y + 2] # Bottom right

  reg_ms.match?("#{tl}#{cr}#{br}") && reg_ms.match?("#{tr}#{cr}#{bl}")
end

for i in (1..the_matrix.length - 2)
  for j in (1..the_matrix[i].length - 2)
    if the_matrix[i][j] == "A" && check_x(the_matrix, i, j)
      sum += 1
    end
  end
end

puts "Total number of X-MASes detected: [#{sum}]"
