class UsersController < ApplicationController
  def index
    render json: UserSerializer.new(User.all).serialized_json
  end

  def create
    if params[:id]
      user = User.find(params[:id])
      user.update(user_params)
    else
      user = User.new(user_params)
    end

    #user.location = Location.all.sample
    if user.save
      render json: UserSerializer.new(user).serialized_json, status: :ok
    else
      render json: user.errors
    end
  end

  def show
    user = User.find(params[:id])
    if user
      render json: UserSerializer.new(user).serialized_json, status: :ok
    else
      render json: user.errors
    end
  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :location_id)
  end


end
