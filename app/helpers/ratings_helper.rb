module RatingsHelper

  def rating_div
    return "star-rating" if @user_rating.blank?
    return "update-star-rating"
  end

end
