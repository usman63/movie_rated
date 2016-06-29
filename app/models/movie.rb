class Movie < ActiveRecord::Base
  GENRE = ["Horror", "Thriller", "Action", "Comedy"]

  has_many :images, as: :imageable

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name,          presence: true, length: { maximum: 60 }
  validates :released_date, presence: true
  validates :duration,                      length: { maximum: 20 }
  validates :genre,                         length: { maximum: 30 }
end
