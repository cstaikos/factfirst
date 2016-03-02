# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do
  pw = Faker::Internet.password
  User.create(
    display_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: pw,
    password_confirmation: pw
  )
end

100.times do
  Fact.create(
    body: Faker::Lorem.sentence,
    user: User.all.sample
  )
end

400.times do
  Evidence.create(
    url: Faker::Internet.url,
    support: [true, false].sample,
    user: User.all.sample,
    fact: Fact.all.sample
  )
end

1000.times do
  Vote.create(
    upvote: [true, false].sample,
    user: User.all.sample,
    evidence: Evidence.all.sample
  )
end

750.times do
  Comment.create(
    body: Faker::Lorem.paragraph,
    user: User.all.sample,
    fact: Fact.all.sample
  )
end
