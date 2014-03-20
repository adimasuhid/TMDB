# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list_tag do
    listable_id 1
    listable_type "MyString"
    taggable_id 1
    taggable_type "MyString"
    temp_user_id "MyString"
  end
end
