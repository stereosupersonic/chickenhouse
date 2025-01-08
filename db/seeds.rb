# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
FactoryBot.create_list :post, 50
FactoryBot.create_list :event, 30

FactoryBot.create :user, email_address: "joe@test.com", password: "test123", password_confirmation: "test123"
FactoryBot.create :admin, email_address: "admin@test.com", password: "test123", password_confirmation: "test123"
