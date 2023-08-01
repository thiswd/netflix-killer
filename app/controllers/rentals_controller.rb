class RentalsController < ApplicationController
  before_action :set_user

  def index
    @rented_movies = @user.rented_movies
    render json: @rented_movies
  end

  def create

  end

  private

  def set_user
    @user ||= User.find(params[:user_id])
  end
end
