# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie_metadatum, :class => 'MovieMetadata' do
    movie_id 1
    movie_type_id 1
    budget 1
    runtime 1
    imdb_id "MyString"
    homepage "MyString"
    approved false
    user_id 1
    temp_user_id "MyString"
  end
end
