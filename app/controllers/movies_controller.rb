class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :get_all_actors
  before_action :authenticate_user!, except: [:show, :index]
  before_action :validate_date_range, only: [:index]

  def index
    @movies = Movie.filter_search(params)
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

    def validate_date_range
      return if params[:start_date].blank? && params[:end_date].blank?
      message =
        if params[:start_date].blank? && params[:end_date].present?
          'Start date should not be blank'
        elsif params[:start_date].present? && params[:end_date].blank?
          'End date should not be blank'
        elsif params[:start_date].to_date > params[:end_date].to_date
          'End date should be after start date'
        end
      redirect_to movies_path, flash: { error: message } if message.present?
    end

    def movie_params
      params.require(:movie).permit(:name, :released_date, :description, :duration, :embeded_url, {images_attributes: [:id, :image, :_destroy]}, :genre, {actor_ids: []}, :featured)
    end
end
