FactoryGirl.define do

  # after(:create) { |object| puts "Created a new #{object}" }

  factory :fact do
    body "Test Fact"
  end

  factory :vote do
    upvote true
  end


end


