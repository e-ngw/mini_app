# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
4.times do
  User.create!(email: Faker::Internet.unique.email,
              password: "password",
              password_confirmation: "password",
              name: Faker::Name.name)
end

user_ids = User.ids

20.times do |index|
  user = User.find(user_ids.sample)
  user.posts.create!(body: "本文#{index}",
                    restaurant_info: "店情報#{index}",
                    food_info: "料理/製品名#{index}")
end
