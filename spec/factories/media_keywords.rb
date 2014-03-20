# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :media_keyword do
    keyword_id 1
    mediable_id 1
    mediable_type "MyString"
    temp_user_id "MyString"
    user_id "MyString"
    approved false
  end
end
