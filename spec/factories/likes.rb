# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
    likable_id 1
    likable_type "MyString"
    status 1
    user_id 1
    temp_user_id "MyString"
  end
end
