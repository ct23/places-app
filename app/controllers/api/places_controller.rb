class Api::PlacesController < ApplicationController
  def index
    @places = Place.all
    render 'index.json.jb'
  end
  def show
    if (@place = Place.find_by(id: params[:id]))
      render 'show.json.jb'
    else
      render json: { error: "Place does not exist." }, status: :bad_request
    end
  end
end
