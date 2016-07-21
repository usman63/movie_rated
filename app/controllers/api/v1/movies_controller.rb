class Api::V1::MoviesController < ApplicationController
  respond_to :json

  DEFAULT_SEARCH_FILTER = { approved: true }
  DEFAULT_SEARCH_ORDER = 'released_date DESC'

  def index
    if params[:search] || params[:genre] || params[:actor] || params[:released_date]
      respond_with search_movie(params)
    else
      respond_with Movie.all
    end
  end

  def show
    id = params[:id]
    movie = Movie.find_by_id(id)
    if movie.present?
      respond_with movie_hash(movie)
    else
      respond_with message: "Movie with id #{id} does not exist"
    end
  end

  private

  def search_movie(params)
    conditions = {
      name: params[:search],
      genre: params[:genre],
      actor: params[:actor],
      released_date: params[:released_date],
    }

    Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
  end

  def movie_hash(movie)
    result = {}
    result[:id] = movie.id
    result[:title] = movie.name
    result[:description] = movie.description
    result[:actors] = movie.actors.select(:id, :name, :gender, :created_at, :updated_at)
    result[:reviews] = movie.reviews.select(:id, :user_id, :rating, :created_at, :updated_at, :report_count)
    result[:ratings] = movie.ratings.select(:id, :review :created_at, :updated_at, :user_id)
    result
  end
end
