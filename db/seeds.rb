# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
  username:              "admin",
  email:                 "admin@example.com",
  password:              "1234",
  password_confirmation: "1234",
  admin:                 true
)
u.save!
# Test user accounts
(1..5).each do |i|
  u = User.new(
    username:              "user#{i}",
    email:                 "user#{i}@example.com",
    password:              "1234",
    password_confirmation: "1234"
  )
  u.save!

  Rails.logger.debug { "#{i} test users created..." } if (i % 5).zero?
end
