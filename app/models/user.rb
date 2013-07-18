class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true

  attr_accessible :email, :password, :password_confirmation, :role, :user_name
end
