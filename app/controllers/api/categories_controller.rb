class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render 'index.json.jb'
  end
  def show
    if ( @category = Category.find_by(id: params[:id]) )
      # If category specified in params exists
      render 'show.json.jb'
    else
      # If category specified does not exist
      render json: { error: "Category does not exist." }, status: :bad_request
    end
  end
end
