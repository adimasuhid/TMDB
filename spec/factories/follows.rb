# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow do
    user_id 1
    follable_id 1
    followable_type "MyString"
    approved false
  end
end
