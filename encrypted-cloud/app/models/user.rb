class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  before_create :set_default_encryption_key
end
