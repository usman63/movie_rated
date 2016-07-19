class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :favorited, polymorphic: true

  def self.favorite(user, movie)
    Favorite.where(user_id: user, favorited_id: movie).first
  end

end
