FactoryGirl.define do
  factory :admin_user do
    email "hello@example.com"
    password "password"
    password_confirmation "password"
  end
end
