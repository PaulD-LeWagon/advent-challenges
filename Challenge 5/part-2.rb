rules_fname = "ex-rules.txt"
pages_fname = "ex-pages.txt"

totals = 0
fixed_totals = 0

manuals = []
valid_manuals = []
invalid_manuals = []

def is_valid_booklet?()
end

def is_valid?(pre_truncated_booklet, antecedents)
  (pre_truncated_booklet & antecedents).length == 0
end

def get_antecedents(page, rules)
  rules.key?(page) ? rules[page] : []
end

rules = File.read(rules_fname).split("\n")
File.read(pages_fname).split("\n") { |pages| manuals << pages.split(",") }

rules_tally = rules.each_with_object({}) do |rule, tally|
  key, value = rule.split("|")
  tally.key?(key) ? tally[key] << value : tally[key] = [value]
end

tally_scores = rules_tally.each_with_object([]) { |(k, v), arr| arr[v.map(&:to_i).sum] = k }

the_rule_set = tally_scores.compact.reverse!

manuals.each do |booklet|
  new_booklet = []
  extra_pages = []
  booklet.each do |page|
    if the_rule_set.include?(page)
      new_booklet[the_rule_set.index(page)] = page
    else
      extra_pages << page
    end
  end
  p "[#{booklet.join(", ")}] [#{(new_booklet + extra_pages).compact.join(", ")}]"
end

# manuals.each do |booklet|
#   valid = nil
#   (0..booklet.length - 1).reverse_each do |i|
#     next if i == 0
#     valid = is_valid?(booklet[0..(i - 1)], get_antecedents(booklet[i], rules_tally))
#     break if not valid
#   end
#   if valid
#     totals += booklet[(booklet.length / 2).floor].to_i
#     valid_manuals << booklet
#   else
#     invalid_manuals << booklet
#   end
# end

# invalid_manuals.each do |booklet|
#   (0..booklet.length - 1).reverse_each do |i|
#     next if i == 0
#     p booklet
#     j = i
#     while j >= 0
#       page = booklet[j]
#       antes = get_antecedents(page, rules_tally)
#       p "#{page} [#{antes.join(", ")}] [#{booklet.join(", ")}] #{is_valid?(booklet[0..(j - 1)], antes)}"
#       if is_valid?(booklet[0..(j - 1)], antes)
#         break
#       else
#         booklet.insert(j - 1, booklet.delete(page))
#       end
#       j -= 1
#     end
#     fixed_totals += booklet[(booklet.length / 2).floor].to_i
#   end
#   p "---" * 2
# end

# puts "Sum total of fixed middle pages: #{fixed_totals}"

# puts "Sum total of valid middle pages: #{totals}"
# puts "Valid: #{valid_manuals.length}"
# valid_manuals.each do |booklet|
#   puts "[#{booklet.join(", ")}]"
# end
