# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    imageable_id 1
    imageable_type "MyString"
    title "MyString"
    image_file "MyString"
    image_type "MyString"
    is_main_image false
    approved false
    user_id 1
    priority "9.99"
    temp_user_id "MyString"
    description "MyText"
  end
end
