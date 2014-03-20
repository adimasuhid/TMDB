# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social_app do
    social_app "MyString"
    link "MyString"
    approved false
  end
end
