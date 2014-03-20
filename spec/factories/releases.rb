# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    movie_id 1
    primary false
    country_id 1
    release_date "2014-03-20 23:41:03"
    certification "MyString"
    confirmed false
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
