class MoviesController < ApplicationController
  def index
    @movies = Movie.select(:id, :title, :genre, :rating, :available_copies)
    @paginated_movies = paginate.call(@movies)
    render json: @paginated_movies
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end
end
