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

25.times do
  Fact.create(
    body: Faker::Lorem.sentence,
    user: User.all.find_by(email: 'cstaikos@gmail.com'),
    category: Category.all.sample
  )
end

20.times do
  url = Faker::Internet.url
  Evidence.create(
    url: url,
    support: [true, false].sample,
    user: User.all.sample,
    fact: Fact.all.sample,
    source: Source.create_from_url(url)
  )
end

20.times do
  url = Faker::Internet.url
  Evidence.create(
      url: url,
      support: [true, false].sample,
      user: User.all.find_by(email: 'cstaikos@gmail.com'),
      fact: Fact.all.sample,
      source: Source.create_from_url(url)
  )
end



750.times do
  Vote.create(
    upvote: [true, false].sample,
    user: User.all.sample,
    evidence: Evidence.all.sample
  )
end

30.times do
  Vote.create(
      upvote: [true, false].sample,
      user: User.all.find_by(email: 'cstaikos@gmail.com'),
      evidence: Evidence.all.sample
  )
end

Fact.all.each { |fact| fact.update_score }
