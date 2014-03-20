# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pending_item do
    pendable_id 1
    pendable_type "MyString"
    user_id 1
    temp_user_id "MyString"
    approvable_id 1
    approvable_type "MyString"
  end
end
