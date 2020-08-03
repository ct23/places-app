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

  def self.yelp_seed
    Place.all.each do |place|
      if !place.api_place_id
        response = HTTP.get("https://api.yelp.com/v3/businesses/search?location=Chicago&term=#{place.name.gsub(" ", "%20")}", :headers => { :Authorization => "Bearer #{Rails.application.credentials.yelp_api[:api_key]}"})
        place.update(
          api_place_id: response.parse["businesses"][0]["id"],
          image_url: response.parse["businesses"][0]["image_url"],
          lat: response.parse["businesses"][0]["coordinates"]["latitude"],
          lon: response.parse["businesses"][0]["coordinates"]["longitude"])
      end
    end
  end

end

# {"businesses"=>[{"id"=>"Imy7MhrTq0z-GQ5RjN_USg", "alias"=>"andysunflower-café-chicago-2", "name"=>"AndySunflower Café", "image_url"=>"https://s3-media2.fl.yelpcdn.com/bphoto/PmFDIyonCVWAcg8dsW6mtA/o.jpg", "is_closed"=>false, "url"=>"https://www.yelp.com/biz/andysunflower-caf%C3%A9-chicago-2?adjust_creative=-Vov8GvSxNfHKi8eLs9aew&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=-Vov8GvSxNfHKi8eLs9aew", "review_count"=>4, "categories"=>[{"alias"=>"coffee", "title"=>"Coffee & Tea"}], "rating"=>5.0, "coordinates"=>{"latitude"=>41.713268, "longitude"=>-87.682102}, "transactions"=>[], "location"=>{"address1"=>"9920 S Western Ave", "address2"=>"", "address3"=>nil, "city"=>"Chicago", "zip_code"=>"60643", "country"=>"US", "state"=>"IL", "display_address"=>["9920 S Western Ave", "Chicago, IL 60643"]}, "phone"=>"+13129613171", "display_phone"=>"(312) 961-3171", "distance"=>21356.051881427007}], "total"=>2, "region"=>{"center"=>{"longitude"=>-87.67776489257812, "latitude"=>41.90515925618311}}}