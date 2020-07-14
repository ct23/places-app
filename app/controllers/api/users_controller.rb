class Api::UsersController < ApplicationController

  # These actions can only be executed by a logged in user, except for create.
  before_action :authenticate_user, except: :create

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    # If user with ID params[:id] exists and is equal to current user:
    if ( @user = User.find_by(id: params[:id] ) && ( @user == current_user ))
      render 'show.json.jb'
    else
      render json: { error: "User does not exist." }, status: :unprocessable_entity
    end
  end

  def update
    
  end


end
