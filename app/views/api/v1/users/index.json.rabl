object @users
attributes :id, :biography, :confirmed_at, :email, :first_name, :image_file, :last_name, :points, :user_type, :created_at, :updated_at
node(:badges) { |user| user.badges }
