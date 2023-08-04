class UsersController < ApplicationController
  before_action :set_user, only: [:recommendations]

  def recommendations
    @recommendations = RecommendationEngine.new(@user).call
    render json: @recommendations
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
