totals = 0
manuals = []
valid_manuals = []

rules = File.read("rules.txt").split("\n")
File.read("pages.txt").split("\n") { |pages| manuals << pages.split(",") }

rules_tally = rules.each_with_object({}) do |rule, tally|
  key, value = rule.split("|")
  tally.key?(key) ? tally[key] << value : tally[key] = [value]
end

manuals.each do |booklet|
  valid = nil
  (0..booklet.length - 1).reverse_each do |i|
    next if i == 0
    page = booklet[i]
    antecedent = rules_tally.key?(page) ? rules_tally[page] : []
    valid = (booklet[0..(i - 1)] & antecedent).length == 0
    break if not valid
  end
  if valid
    totals += booklet[(booklet.length / 2).floor].to_i
    valid_manuals << booklet
  end
end

puts "Sum total of valid middle pages: #{totals}"
puts "Valid: #{valid_manuals.length}"
valid_manuals.each do |booklet|
  puts "[#{booklet.join(", ")}]"
end
