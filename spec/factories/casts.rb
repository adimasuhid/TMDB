# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cast do
    approved false
    character "MyString"
    movie_id 1
    person_id 1
    user_id 1
    temp_user_id "MyString"
  end
end
