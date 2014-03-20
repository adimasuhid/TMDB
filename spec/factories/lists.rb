# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list do
    description "MyText"
    title "MyString"
    user_id 1
    list_type "MyString"
    temp_user_id "MyString"
    approved false
  end
end
