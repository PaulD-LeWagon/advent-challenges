#!/usr/bin/env ruby

# Challenge #6

$coords = {}
$coord_sigs = []
$pos = {}
$orientation = ["^", ">", "v", "<"]
$map = []

File.read("input.txt").split("\n").each_with_index do |line, i|
  row = line.chars
  $pos = { x: row.index("^"), y: i } if row.include?("^")
  $map << row
end

$cur_dir = $map[$pos[:y]][$pos[:x]]

$map_dim = { x: $map.first.length, y: $map.length }

def print_number_of_unique_steps
  puts "Total number of unique steps taken: #{$coord_sigs.uniq { |item| "#{item[1]}:#{item[2]}" }.size}"
end

def going_round_in_circles?(dir, the_map, pos)
  x = pos[:x]
  y = pos[:y]
  case dir
  when "^"
    y -= 1
  when ">"
    x += 1
  when "v"
    y += 1
  when "<"
    x -= 1
  else
    raise "Invalid Direction Exception: #{dir}"
  end
  $coord_sigs.include?("#{dir}#{x}#{y}")
end

def can_move?(dir, the_map, pos)
  case dir
  when "^"
    pos[:y] - 1 >= 0 and the_map[pos[:y] - 1][pos[:x]] == "."
  when ">"
    pos[:x] + 1 < $map_dim[:x] and the_map[pos[:y]][pos[:x] + 1] == "."
  when "v"
    pos[:y] + 1 < $map_dim[:y] and the_map[pos[:y] + 1][pos[:x]] == "."
  when "<"
    pos[:x] - 1 >= 0 and the_map[pos[:y]][pos[:x] - 1] == "."
  else
    raise "Invalid Direction Exception: #{dir}"
  end
end

def move(dir, the_map, pos)
  return_value = false
  pos[:dir] = dir
  the_map[pos[:y]][pos[:x]] = "." if $orientation.include?(the_map[pos[:y]][pos[:x]])
  case dir
  when "^"
    if pos[:y] - 1 >= 0
      pos[:y] = pos[:y] - 1
      return_value = true
    end
  when "v"
    if pos[:y] + 1 < $map_dim[:y]
      pos[:y] = pos[:y] + 1
      return_value = true
    end
  when "<"
    if pos[:x] - 1 >= 0
      pos[:x] = pos[:x] - 1
      return_value = true
    end
  when ">"
    if pos[:x] + 1 < $map_dim[:x]
      pos[:x] = pos[:x] + 1
      return_value = true
    end
  else
    raise "Invalid Direction Exception: #{dir}"
  end
  coord_key = "#{pos[:dir]}#{pos[:x]}#{pos[:y]}"
  if $coord_sigs.include?(coord_key)
    raise "Duplicate Coord Key: #{coord_key} we must be in a loop"
  else
    $coord_sigs << [coord_key, pos[:x], pos[:y]]
  end
  return_value
end

def is_obstacle?(dir, the_map, pos)
  return false if off_the_map?(dir, the_map, pos)
  case dir
  when "^"
    the_map[pos[:y] - 1][pos[:x]] == "#"
  when "v"
    the_map[pos[:y] + 1][pos[:x]] == "#"
  when "<"
    the_map[pos[:y]][pos[:x] - 1] == "#"
  when ">"
    the_map[pos[:y]][pos[:x] + 1] == "#"
  else
    raise "Invalid Direction Exception: #{dir}"
  end
end

def off_the_map?(dir, the_map, pos)
  case dir
  when "^"
    pos[:y] - 1 < 0
  when "v"
    pos[:y] + 1 >= $map_dim[:y]
  when "<"
    pos[:x] - 1 < 0
  when ">"
    pos[:x] + 1 >= $map_dim[:x]
  else
    raise "Invalid Direction Exception: #{dir}"
  end
end

File.delete("output.txt") if File.exist?("output.txt")
loop do
  if not going_round_in_circles?($cur_dir, $map, $pos)
    if can_move?($cur_dir, $map, $pos)
      move($cur_dir, $map, $pos)
      File.open("output.txt", "a") do |file|
        file.write("#{$cur_dir}, #{$pos[:spot]}, #{$pos[:x]}, #{$pos[:y]}\n")
      end
    elsif is_obstacle?($cur_dir, $map, $pos)
      # Turn right and try again
      $orientation = $orientation.rotate
      $cur_dir = $orientation.first
    elsif off_the_map?($cur_dir, $map, $pos)
      # Walking off the map. So, exit the loop
      print_number_of_unique_steps
      break
    end
  else
    # We are looping round the map. So, exit this loop too
    print_number_of_unique_steps
    break
  end
end
