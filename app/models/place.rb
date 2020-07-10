class Place < ApplicationRecord
  # Association methods
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :category

end
