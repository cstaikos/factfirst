FactoryGirl.define do

  # after(:create) { |object| p object }

  factory :fact do
    body "Test Fact"
    category
  end

  factory :vote do
  end

end


