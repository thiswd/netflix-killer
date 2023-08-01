# app/services/rent_movie_service.rb
class RentMovieService
  attr_reader :user, :movie

  def initialize(user, movie_id)
    @user = user
    @movie = Movie.find(movie_id)
  end

  def call
    raise ActiveRecord::RecordInvalid.new(movie) if movie.available_copies <= 0

    ActiveRecord::Base.transaction do
      movie.update!(available_copies: movie.available_copies - 1)
      user.rentals.create!(movie: movie)
      return movie
    end
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end
