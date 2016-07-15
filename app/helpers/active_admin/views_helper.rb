module ActiveAdmin::ViewsHelper

 def attachment_image(attachment)
   attachment.image.url(:medium) unless attachment.new_record?
 end

end
