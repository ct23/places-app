class User < ApplicationRecord
  # Association methods
  has_many :favorites
  has_many :places, through: :favorites

  # bcrypt method:
  has_secure_password
  
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
