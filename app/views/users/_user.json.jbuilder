json.extract! user, :id, :name, :gender, :email, :phone_number, :remarks, :created_at, :updated_at
json.url user_url(user, format: :json)
