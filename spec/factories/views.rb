# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :view do
    viewable_type ""
    viewable_id 1
    views_count 1
    user_id 1
    temp_user_id "MyString"
  end
end
