FactoryGirl.define do
  # factory :evidence do
  #   url "https://www.test.com"
  #   support true
  #   user_id 1
  #   fact_id 1
  # end

  factory :evidence do
    url "https://www.test.com"
    support true

    factory :supporting_evidence do
      support true
    end

    factory :refuting_evidence do
      support false
    end
  end

end
