class RentalsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index

  end

  def create
    result = RentMovieService.new(@user, movie_id).call

    if result[:error]
      render json: { error: result[:error] }, status: :unprocessable_entity
    else
      render json: result, status: :updated
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
end
