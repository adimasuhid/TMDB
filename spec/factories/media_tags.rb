# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :media_tag do
    mediable_id 1
    mediable_type "MyString"
    taggable_id 1
    taggable_type "MyString"
    temp_user_id "MyString"
    approved false
  end
end
