class Movie < ActiveRecord::Base
  include ThinkingSphinx::Scopes

  paginates_per 3

  DEFAULT_SEARCH_FILTER = { approved: true }
  DEFAULT_SEARCH_ORDER = 'released_date DESC'

  MOVIE_LMIIT = 3
  GENRE = ["Horror", "Thriller", "Action", "Comedy"]

  has_many :images, as: :imageable
  has_many :movie_casts
  has_many :actors, through: :movie_casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourites, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  sphinx_scope(:latest) {{order: 'released_date DESC'}}
  sphinx_scope(:by_genre) {|genre|{conditions: {genre: genre}}}

  sphinx_scope(:by_featured) {{with: {is_featured: true}}}
  sphinx_scope(:approved) {{with: {approved: true}}}
  sphinx_scope(:by_actors) {|actors| {conditions: {actor: actors}}}
  sphinx_scope(:by_date) {|released_date| {with: {released_date: released_date}}}

  validates :name,          presence: true, length: { maximum: 60 }
  validates :released_date, presence: true
  validates :duration,                      length: { maximum: 20 }
  validates :genre,                         length: { maximum: 30 }

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
    images.last
  end

  def self.filter_search(params)
    default_options = {
      conditions: {},
      with: {},
      order: 'released_date  DESC',
      page: params[:page],
      per_page: 4
    }

    default_options[:conditions][:genre] = params[:genre] if params[:genre].present?
    default_options[:conditions][:actor] = params[:actor] if params[:actor].present?
    default_options[:with][:approved] = true

    if params[:start_date].present? && params[:end_date].present?
      default_options[:with][:released_date] = (Date.parse(params[:start_date])..Date.parse(params[:end_date]))
    end

    self.search params[:search], default_options
  end



  def movie_hash
    if self.present?
      movie = Hash.new
      movie[:id] = self.id
      movie[:title] = self.title
      movie[:description] = self.description
      movie[:actors] = self.actors.select(:id, :name, :biography, :gender, :created_at, :updated_at)
      movie[:reviews] = self.reviews.select(:id, :user_id, :comment, :created_at, :updated_at, :report_count)
      movie[:ratings] = self.ratings.select(:id, :score, :created_at, :updated_at, :user_id)
      movie
    end
  end

  def self.search_movie(params)
    conditions = {
      name: params[:search],
      genre: params[:genre],
      actor: params[:actor],
      released_date: params[:released_date]
      }

    Movie.search(conditions: conditions, with: DEFAULT_SEARCH_FILTER, order: DEFAULT_SEARCH_ORDER)
  end

end
