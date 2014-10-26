json.array!(@users) do |user|
  json.extract! article, :id, :username
  json.url user_url(user, format: :json)
end
