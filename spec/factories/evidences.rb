FactoryGirl.define do

  factory :evidence do
    url "https://www.test.com"
    support true
    source

    factory :supporting_evidence do
      support true
    end

    factory :refuting_evidence do
      support false
    end
  end

end
