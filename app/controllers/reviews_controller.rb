class ReviewsController < ApplicationController

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_movie
  before_action :validates_review_user, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @review = @movie.reviews.create(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @movie, notice: 'Review was successfully created.' }
        format.js
      else
        flash[:errors] = @review.errors.full_messages
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @movie, notice: 'Review was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validates_review_user
      flash[:errors] = 'Not Authorized'
      return redirect_to @movie if @review.user.id != current_user.id
    end
    def set_review
      @review = Review.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:review)
    end
end
