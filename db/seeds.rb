# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  pw = Faker::Internet.password
  User.create(
    display_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: pw,
    password_confirmation: pw
  )
end

User.create(
  display_name: 'cstaikos',
  email: 'cstaikos@gmail.com',
  password: '123123123',
  password_confirmation: '123123123'
)

10.times do |i|
  categories = %w(Business Politics Science Culture Religion Sports News)
  Category.create(
    name: categories[i]
  )
end

50.times do
  Fact.create(
    body: Faker::Lorem.sentence,
    user: User.all.sample,
    category: Category.all.sample
  )
end

# Maximum possible length fact taking up as much space as possible - use this to test how much space we have on the image overlay
text = ""
255.times { text << "M" }

Fact.create(
  body: text,
  user: User.all.sample
)

250.times do
  Evidence.create(
    url: Faker::Internet.url,
    support: [true, false].sample,
    user: User.all.sample,
    fact: Fact.all.sample
  )
end

750.times do
  Vote.create(
    upvote: [true, false].sample,
    user: User.all.sample,
    evidence: Evidence.all.sample
  )
end

125.times do
  Comment.create(
    body: Faker::Lorem.paragraph,
    user: User.all.sample,
    fact: Fact.all.sample
  )
end

Fact.all.each { |fact| fact.update_score }
