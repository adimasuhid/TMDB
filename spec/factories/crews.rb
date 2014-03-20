# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crew do
    movie_id 1
    person_id 1
    job "MyString"
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
