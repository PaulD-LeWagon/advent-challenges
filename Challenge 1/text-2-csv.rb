File.open("chal-1-data.txt") do |in_file|
  File.open("chal-1-data.csv", "w") do |out_file|
    in_file.each { |line| out_file << line.squeeze(" ").gsub(" ", ",") }
  end
end
