class RentalsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @rented_movies = @user.rented_movies
    render json: @rented_movies
  end

  def create
    rented_movie = RentMovieService.new(@user, movie_id).call

    if rented_movie[:error]
      render json: { error: rented_movie[:error] }, status: :unprocessable_entity
    else
      render json: rented_movie, status: :created
    end
  end

  private

  def set_user
    @user ||= User.find(params[:user_id])
  end

  def rental_params
    params.require(:rental).permit(:movie_id)
  end

  def movie_id
    params[:rental][:movie_id]
  end

  private

  def set_user
    @user ||= User.find(params[:user_id])
  end
end
