class PagesController < ApplicationController

  def home
    @featured_movies = Movie.featured.take(Movie::MOVIE_LMIIT)
    @latest_movies = Movie.latest.take(Movie::MOVIE_LMIIT)
  end

end
