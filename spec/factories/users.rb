FactoryGirl.define do
  factory :user do
    display_name "test_user"
    email "test@test.com"
    password "boogerss"
    password_confirmation "boogerss"
  end
end
