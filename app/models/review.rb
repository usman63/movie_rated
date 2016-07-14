class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie
  has_many :report_reviews, dependent: :destroy

  scope :ordered, -> { order('created_at DESC') }
  validates :review, presence: true

  def has_report?(user)
    self.report_reviews.where(user: user).count > 0
  end

end
