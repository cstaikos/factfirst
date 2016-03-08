FactoryGirl.define do
  factory :user do
    display_name "test_user"
    email "test@test.com"
    password "boogers"
    password_confirmation "boogers"
  end
end
