# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list_keyword do
    keyword_id 1
    listable_id 1
    listable_type "MyString"
    temp_user_id "MyString"
    user_id 1
    approved false
  end
end
