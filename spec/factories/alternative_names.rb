# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alternative_name do
    alternative_name "MyString"
    approved false
    person_id 1
    user_id 1
    temp_user_id "MyString"
  end
end
