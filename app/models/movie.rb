class Movie < ActiveRecord::Base
  paginates_per 6

  MOVIE_LMIIT = 3
  GENRE = ["Horror", "Thriller", "Action", "Comedy"]

  has_many :images, as: :imageable
  has_many :movie_casts
  has_many :actors, through: :movie_casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  scope :featured, -> { where(featured: true) }
  scope :latest, -> { order(released_date: :desc) }

  validates :name,          presence: true, length: { maximum: 60 }
  validates :released_date, presence: true
  validates :duration,                      length: { maximum: 20 }
  validates :genre,                         length: { maximum: 30 }

  def self.get_movies (params)
    return self.featured if params[:featured].present?
    return self.latest if params[:latest].present?
    return self.all
  end

  def user_rating(user)
    self.ratings.where(user: user).last if user.present?
  end

  def cal_average_rating()
    return 0 unless self.ratings.exists?
    self.ratings.average(:rating).round(2)
  end

  def cast
    self.actors.pluck(:name).join(', ')
  end

  def last_poster
    images.first
  end
end
