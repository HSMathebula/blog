json.extract! user, :id, :name, :photo, :bio, :postsCounter, :created_at, :updated_at
json.url user_url(user, format: :json)
