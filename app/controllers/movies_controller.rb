class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :get_all_actors
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @movies = Movie.get_movies(params).page(params[:page])
  end

  def show
    @movie_actors = @movie.cast
    @reviews = @movie.reviews.includes(:user).ordered
    @review = @movie.reviews.build
    @rating = @movie.ratings.build
    @user_rating = @movie.user_rating(current_user)
    @avg_rating = @movie.cal_average_rating
    @favorite = Favorite.favorite(current_user, @movie ) if user_signed_in?
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie_actors = @movie.actors.pluck(:id)
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_all_actors
    @all_actors = Actor.all
  end

  private

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:name, :released_date, :description, :duration, :embeded_url, {images_attributes: [:id, :image, :_destroy]}, :genre, {actor_ids: []}, :featured)
    end
end
