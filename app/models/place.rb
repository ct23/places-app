class Place < ApplicationRecord
  # Association methods
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :category

  # Yelp methods
  def details(yelp_id)
    request = HTTP.get("https://api.yelp.com/v3/businesses/#{yelp_id}", :headers => { :Authorization => "Bearer #{Rails.application.credentials.yelp_api[:api_key]}"})
    request.parse
  end

  def reviews(yelp_id)
    request = HTTP.get("https://api.yelp.com/v3/businesses/#{yelp_id}/reviews", :headers => { :Authorization => "Bearer #{Rails.application.credentials.yelp_api[:api_key]}"})
    request.parse
  end

end
