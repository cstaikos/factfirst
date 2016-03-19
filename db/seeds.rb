8.times do |i|
  categories = %w(Business Politics Science Culture Religion Sports Health Silly)
  Category.create(
    name: categories[i]
  )
end

load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"), '/')
