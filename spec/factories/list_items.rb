# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list_item do
    list_id 1
    listable_id 1
    listable_type "MyString"
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
