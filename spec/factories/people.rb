# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "MyString"
    biography "MyText"
    birthday "2014-03-20 23:38:19"
    day_of_death "2014-03-20 23:38:19"
    place_of_birth "MyString"
    homepage "MyString"
    imdb_id "MyString"
    approved false
    locked ""
    user_id 1
    original_id 1
    temp_user_id "MyString"
    popular "9.99"
    meta_title "MyString"
    meta_description "MyString"
    meta_keywords "MyString"
  end
end
