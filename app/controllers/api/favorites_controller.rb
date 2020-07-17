class Api::FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favorites = current_user.favorites
    render 'index.json.jb'
  end

  def create
    @favorite = Favorite.new(
      user_id: current_user.id,
      place_id: params[:place_id]
    )
    if @favorite.save
      render 'show.json.jb'
    else
      render  json: { error: @favorite.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    if ( @favorite = Favorite.find_by(id: params[:id]) )
      # If favorite with specified ID exists
      if ( @favorite.user_id == current_user.id )
        # If favorite exists, and is owned by current user
        @favorite.destroy
        render json: { message: "Favorite was deleted." }
      else
        # If favorite exists, and is not owned by current user
        render json: { message: "You are not authorized to view this page" }, status: :unauthorized
      end
    else
      # If favorite with specified ID does not exist
      render json: { error: "Page does not exist" }, status: :bad_request
    end
  end
end
