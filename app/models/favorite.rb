class Favorite < ApplicationRecord
  # Association methods
  belongs_to :user
  belongs_to :place
end
