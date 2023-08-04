class MoviesController < ApplicationController
  def index
    @movies = Movie.select(:id, :title, :genre, :rating, :available_copies)
    @paginated_movies = paginate.call(@movies)
    render json: @paginated_movies
  end
end
