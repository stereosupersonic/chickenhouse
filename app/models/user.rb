# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default(FALSE)
#  email_address   :string
#  password_digest :string
#  slug            :string
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, length: { minimum: 8, message: "must be at least 8 characters long" }, allow_nil: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :username, with: ->(u) { u.strip }
end
