# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    taggable_id 1
    taggable_type ""
    person_id 1
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
