File.open("raw-data.txt") do |in_file|
  File.open("test-data.csv", "w") do |out_file|
    in_file.each { |line| out_file << line.squeeze(" ").gsub(" ", ",") }
  end
end
