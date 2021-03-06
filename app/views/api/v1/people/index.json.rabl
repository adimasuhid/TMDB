object @people
attributes :id, :original_id, :user_id, :approved, :biography, :birthday, :day_of_death, :homepage, :imdb_id, :locked, :name, :place_of_birth, :created_at, :updated_at
if @all
  node(:images) { |person| person.images }
else
  node(:images) { |person|
    person.images.select {|s| s.approved == true }
  }
end
