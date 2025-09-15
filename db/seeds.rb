# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

FactoryBot.create_list :post, 50
FactoryBot.create_list :event, 30

FactoryBot.create :user, email_address: "joe@test.com", password: "test123456", password_confirmation: "test123456"
FactoryBot.create :admin, email_address: "admin@test.com", password: "test123456", password_confirmation: "test123456"
