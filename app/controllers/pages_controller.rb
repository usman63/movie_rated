class PagesController < ApplicationController

  def home
    @featured_movies = Movie.by_featured.approved.take(Movie::MOVIE_LMIIT)
    @latest_movies = Movie.latest.approved.take(Movie::MOVIE_LMIIT)
  end

end
