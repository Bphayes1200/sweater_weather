class User < ApplicationRecord
  has_many :api_keys
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation
  has_secure_password
end