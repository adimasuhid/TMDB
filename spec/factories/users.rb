# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    biography "MyText"
    email "wat@example.com"
    password "sample12345"
    user_type "MyString"
    image_file "MyString"
    confirmed_at "2014-03-20 23:45:45"
    points 1
    active false
  end
end
