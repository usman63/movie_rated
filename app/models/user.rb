class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :image, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :first_name, presence: true, length: {minimum: 5, maximum: 60}
  validates :last_name, presence: true, length: {minimum: 5, maximum: 60}

  accepts_nested_attributes_for :image

end
