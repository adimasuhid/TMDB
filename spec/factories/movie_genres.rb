# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_genre do
    movie_id 1
    genre_id 1
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
