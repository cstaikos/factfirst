FactoryGirl.define do

  after(:create) { |object| puts "Creates #{object} It fucking worked - ugh" }

  factory :fact do
    body "This is a random fact!"
    user_id 1
    score 5
  end

end


# FactoryGirl.define do
#   factory :evidence do
#     url "https://www.test.com"
#     support true
#     user_id 1
#     fact_id 1
#   end
# end
