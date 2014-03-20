# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alternative_title do
    alternative_title "MyString"
    approved false
    language_id 1
    movie_id 1
    user_id 1
    temp_userid "MyString"
  end
end
