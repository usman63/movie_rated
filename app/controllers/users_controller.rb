class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
    @favourite_movies = current_user.favorite_movies.page(params[:page]) if current_user.favorite_movies
  end

end
