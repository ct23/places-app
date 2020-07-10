class User < ApplicationRecord
  # Association methods
  has_many :favorites
  has_many :places, through: :favorites
end
