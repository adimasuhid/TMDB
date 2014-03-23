# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    link "http://foo.com"
    videable_id 1
    videable_type "MyString"
    video_type "MyString"
    quality "MyString"
    link_active false
    approved false
    user_id 1
    title "MyString"
    description "MyText"
    comments "MyString"
    category "MyString"
    duration "MyString"
    thumbnail "MyString"
    temp_user_id "MyString"
    thumbnail2 "MyString"
    thumbnail3 "MyString"
    priority "9.99"
  end
end
