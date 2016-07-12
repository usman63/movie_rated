class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie

  scope :ordered, -> { order('created_at DESC') }
  validates :review, presence: true
end
