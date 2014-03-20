# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_language do
    approved false
    language_id 1
    movie_id 1
    user_id 1
    temp_user_id "MyString"
  end
end
