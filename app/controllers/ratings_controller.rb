class RatingsController < ApplicationController
  before_action :set_rating, only: [:update]
  before_action :authenticate_user!
  before_action  :set_movie

  def create
    @rating = @movie.ratings.create(rating: rating_params[:rating], user: current_user)
    @rating.save
  end

  def update
    @rating.update(rating: rating_params[:rating])
  end

  private

    def set_rating
      @rating = Rating.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def rating_params
      params.require(:rating).permit(:rating, :movie)
    end
end
