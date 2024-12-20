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

def valid_booklet?(booklet, rules_tally)
  valid = true
  (0..booklet.length - 1).reverse_each do |i|
    next if i == 0
    valid = (booklet[0..(i - 1)] & (rules_tally.key?(booklet[i]) ? rules_tally[booklet[i]] : [])).length == 0
    break if not valid
  end
  return valid
end

def return_invalid_page(booklet, rules_tally)
  invalid_page = nil
  (0..booklet.length - 1).reverse_each do |i|
    next if i == 0
    if (booklet[0..(i - 1)] & (rules_tally.key?(booklet[i]) ? rules_tally[booklet[i]] : [])).length != 0
      invalid_page = booklet[i]
      break
    end
  end
  return invalid_page
end

manuals.each do |booklet|
  if valid_booklet?(booklet, rules_tally)
    totals += booklet[(booklet.length / 2).floor].to_i
    valid_manuals << booklet
  else
    # Should really be a Do-While loop, but Ruby doesn't really
    # have one. Well, there's the Loop do...end loop, but that's
    # ugly as sin!
    while not valid_booklet?(booklet, rules_tally)
      page = return_invalid_page(booklet, rules_tally)
      i = booklet.index(page)
      antecedents = (booklet[0..(i - 1)] & (rules_tally.key?(page) ? rules_tally[page] : []))
      next if antecedents.length == 0
      booklet.delete_at(booklet.index(page))
      booklet.insert(booklet.index(antecedents.first), page)
    end
    fixed_manuals << booklet
    fixed_totals += booklet[(booklet.length / 2).floor].to_i
  end
end

# tally_scores = rules_tally.each_with_object([]) { |(k, v), arr| arr[v.map(&:to_i).sum] = k }
# the_rule_set = tally_scores.compact.reverse!
# manuals.each do |booklet|
#   if valid_booklet?(booklet, rules_tally)
#     totals += booklet[(booklet.length / 2).floor].to_i
#     valid_manuals << booklet
#   else
#     new_booklet = []
#     extra_pages = []
#     booklet.each do |page|
#       if the_rule_set.include?(page)
#         new_booklet[the_rule_set.index(page)] = page
#       else
#         extra_pages << page
#       end
#     end
#     booklet = (new_booklet + extra_pages).compact
#     fixed_manuals << booklet
#     fixed_totals += booklet[(booklet.length / 2).floor].to_i
#   end
# end

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
