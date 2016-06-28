module ApplicationHelper

  def show_image(attachment)
    attachment.image.url(:medium) if attachment
  end

end
