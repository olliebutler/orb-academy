class Basket
  def total(books)
    [
      calculate(longest_set(books, 5)),
      calculate(longest_set(books, 4))
    ].min
  end

  def calculate(sets)
    sets.inject(0) { |acc, set|
      acc + set.length * unit_price * discount_multiplier(set.length)
    }.to_i
  end

  def longest_set(books, maximum)
    set = books.uniq.take(maximum)
    leftovers = remove_books(books, set)
    if leftovers.any?
      [set] + longest_set(leftovers, maximum)
    else
      [set]
    end
  end

  def remove_books(books, to_remove)
    grouped = books.group_by { |a| a }
    to_remove.each do |n|
      grouped[n].pop
    end
    leftovers = grouped.values.flatten
  end

  def unit_price
    800
  end

  def discount_multiplier(length)
    case length
    when 1
      1
    when 2
      0.95
    when 3
      0.9
    when 4
      0.8
    when 5
      0.75
    end
  end
end
