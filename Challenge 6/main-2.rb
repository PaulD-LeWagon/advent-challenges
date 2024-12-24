#!/usr/bin/env ruby

map = []
md = { x: 130, y: 130 }
(0..md[:y] - 1).each do |y|
  map[y] = [] if map[y].nil?
  (0..md[:x] - 1).each do |x|
    map[y][x] = "."
  end
end

File.read("output.txt").split("\n").each do |line|
  v = line.split(", ")
  x = v[2].to_i
  y = v[3].to_i
  map[y][x] = v.first
end

map.each do |row|
  File.open("processed-map.txt", "w") do |file|
    if row.length == 0
      (0..row_length - 1).each do |i|
        row << "."
      end
    else
      (0..row.length - 1).each do |i|
        # p row[i]
        row[i] = "." if row[i].nil?
        # p row[i]
      end
    end
    file.write("#{row.join}\n")
  end
end

map.each do |row|
  # p row
end
