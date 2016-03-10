8.times do |i|
  categories = %w(Business Politics Science Culture Religion Sports News Silly)
  Category.create(
    name: categories[i]
  )
end
