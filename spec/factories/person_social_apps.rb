# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_social_app do
    person_id 1
    social_app_id 1
    profile_link "MyString"
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
