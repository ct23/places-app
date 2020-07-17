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
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    # If user with ID params[:id] exists and is equal to current user:
    @user = User.find_by(id: params[:id])
    if @user == current_user
      render 'show.json.jb'
    else
      render json: { error: "You are not authorized to view this page"}, status: :unauthorized
    end
    # else
    #   render json: { error: "User does not exist." }, status: :bad_request
    # end

  end

  def update
    @user = User.find_by(id: params[:id])
    if @user == current_user
      @user.name = params[:name] || @user.name
      @user.email = params[:email] || @user.email
      # If user wants to update password:
      if params[:password] && params[:password_confirmation]
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
      end
      if @user.save
        render 'show.json.jb'
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "You are not authorized to view this page"}, status: :unauthorized
    end
  end

  def destroy
    if ( @user = User.find_by(id: params[:id]) )
      # If user with specified ID exists
      if @user == current_user
        # If specified user is the current user
        @user.destroy
        render json: { message: "User was deleted." }
      else
        # If specified user is not the current user
        render json: { error: "You are not authorized to view this page"}, status: :unauthorized
      end
    else
      # If user with specified ID does not exist
      render json: { error: "You are not authorized to view this page"}, status: :unauthorized
    end
  end
end
