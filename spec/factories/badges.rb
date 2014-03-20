# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :badge do
    badge "MyString"
    min_points 1
  end
end
