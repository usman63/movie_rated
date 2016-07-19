class Image < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: { medium: "300x300!" }, default_url: "/images/missing.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image

end
