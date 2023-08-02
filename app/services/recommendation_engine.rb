class RecommendationEngine
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    common_genres = fetch_common_genres
    Movie.where(genre: common_genres)
      .where.not(id: @user.favorites.select(:id))
      .where.not(id: @user.rented.select(:id))
      .order(rating: :desc)
      .limit(10)
  end

  private

  def fetch_common_genres
    user.favorites
      .group(:genre)
      .order('count_genre desc')
      .limit(3)
      .count(:genre)
      .keys
  end
end
