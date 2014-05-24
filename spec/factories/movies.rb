# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "MyString"
    tagline "MyString"
    overview "MyText"
    content_score 1
    approved false
    locked []
    user_id 1
    popular "9.99"
    temp_user_id "MyString"
    meta_title "MyString"
    meta_description "MyString"
    meta_keywords "MyString"
  end
end
