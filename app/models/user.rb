class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :image, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :report_reviews, dependent: :destroy

  validates :first_name, presence: true, length: {minimum: 5, maximum: 60}
  validates :last_name, presence: true, length: {minimum: 5, maximum: 60}
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  accepts_nested_attributes_for :image

end
