text = File.read("input_data.txt").gsub(/\n/, "")

# p text.scan(/(?<multiply>mul\((?<m1>\d{1,3}),(?<m2>\d{1,3})\))/)

sum = 0

lines = text.split(/(do\(\))/)
lines.each do |line|
  line.gsub!(/(don't\(\).*)/, "[...]")
  line.scan(/(mul\((\d{1,3}),(\d{1,3})\))/) do |m|
    sum += m[1].to_i * m[2].to_i
  end
  p line
end

puts "Total: #{sum}"
