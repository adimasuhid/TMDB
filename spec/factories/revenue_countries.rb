# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :revenue_country do
    country_id 1
    movie_id 1
    revenue 1
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
