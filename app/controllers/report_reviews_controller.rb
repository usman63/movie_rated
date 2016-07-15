class ReportReviewsController < ApplicationController

  before_action :set_report_review, only: [:destroy]
  before_action :get_review
  before_action :authenticate_user!

  def create
    return false if @review.has_report?(current_user)
    @report_review = @review.report_reviews.build
    @report_review.user = current_user
    @report_review.save
  end

  def destroy
    @report_review.destroy
  end

  private
    def set_report_review
      @report_review = ReportReview.find(params[:id])
    end

    def get_review
      @review = Review.find(params[:review_id])
    end

end
