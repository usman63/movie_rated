class FavoriteMoviesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_movie
  before_action :set_user
  before_action :set_favorite, only: [:destroy]

  def create
    if @user.favorites.create(favorited: @movie)
      redirect_to @movie, notice: 'Movie has been favorited'
    else
      redirect_to @movie, alert: 'Something went wrong...'
    end
  end

  def destroy
    @favorite = Favorite.favorite(@user, @movie)
    if @favorite.destroy
      redirect_to @movie, notice: 'Movie is no longer in favorites'
    end
  end

  private

  def set_movie
    @movie = Movie.find( params[:movie_id])
  end

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end
