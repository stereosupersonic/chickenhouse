# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  slug            :string(255)
#

class User < ActiveRecord::Base

  has_secure_password

  validates :username, :email, :presence => true
  validates :username, :uniqueness  => { case_sensitive: false }
  validates :email,    :uniqueness  => { case_sensitive: false }
  validates :password, :length => { :minimum => 4 }, :on =>  :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,  :on =>  :create
  def label
    "#{username} (#{email})"
  end
  def self.reset_admin(pw)
    u = User.find_or_create_by(:username => 'admin')
    u.attributes= {:admin => true,  :password => pw, :password_confirmation => pw, :email => "info@henaheisl.de"}
    u.save!
    u
  end
end
