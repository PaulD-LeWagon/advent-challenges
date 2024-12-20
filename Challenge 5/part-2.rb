# Initialisation
totals = 0
fixed_totals = 0

manuals = []
valid_manuals = []
fixed_manuals = []

rules_fname = "rules.txt"
pages_fname = "pages.txt"

rules = File.read(rules_fname).split("\n")

File.read(pages_fname).split("\n") { |pages| manuals << pages.split(",").map(&:to_i) }

rules_tally = rules.each_with_object({}) do |rule, tally|
  key, value = rule.split("|").map(&:to_i)
  tally.key?(key) ? tally[key] << value : tally[key] = [value]
end
tally_scores = rules_tally.each_with_object([]) { |(k, v), arr| arr[v.map(&:to_i).sum] = k }
the_rule_set = tally_scores.compact.reverse!

def valid_booklet?(booklet, rules_tally)
  valid = true
  (0..booklet.length - 1).reverse_each do |i|
    next if i == 0
    valid = (booklet[0..(i - 1)] & (rules_tally.key?(booklet[i]) ? rules_tally[booklet[i]] : [])).length == 0
    break if not valid
  end
  return valid
end

manuals.each do |booklet|
  if valid_booklet?(booklet, rules_tally)
    totals += booklet[(booklet.length / 2).floor].to_i
    valid_manuals << booklet
  else
    new_booklet = []
    extra_pages = []
    booklet.each do |page|
      if the_rule_set.include?(page)
        new_booklet[the_rule_set.index(page)] = page
      else
        extra_pages << page
      end
    end
    booklet = (new_booklet + extra_pages).compact
    fixed_manuals << booklet
    fixed_totals += booklet[(booklet.length / 2).floor].to_i
  end
end

puts "Sum total of valid middle pages: #{totals}"
puts "Sum total of fixed middle pages: #{fixed_totals}"

puts "Valid: #{valid_manuals.length}"
valid_manuals.each do |booklet|
  puts "[#{booklet.join(", ")}]"
end

puts "Fixed: #{fixed_manuals.length}"
fixed_manuals.each do |booklet|
  puts "[#{booklet.join(", ")}]"
end
