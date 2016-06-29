class Actor < ActiveRecord::Base

  has_many :movie_casts
  has_many :movies, through: :movie_casts

  validates :name,          presence: true, length: { maximum: 60 }
  validates :country,                       length: { maximum: 50 }
  validates :gender,                        length: { maximum: 10 }

end
