ActiveAdmin.register Movie do

  permit_params :name, :description, :embeded_url, {actor_ids: []}, :is_featured, :approved, images_attributes: [:id, :image, :_destroy]

  filter :name
  filter :is_featured
  filter :actors
  filter :released_date

  show do
      attributes_table do
        row "Image" do |m|
            m.images.each do |attachment|
              div do
                image_tag(attachment_image attachment) if attachment.image
              end
            end
        end
        row :name
        row :description
        row :embeded_url
        row :featured
        row :approved
        row :actors do |movie|
          movie.cast
        end
      end
  end

  index do
    column :name
    column :description
    column :embeded_url
    column :is_featured
    column :approved
    column :actors do |movie|
      movie.cast
    end
    column "Image" do |movie|
      image_tag(attachment_image movie.last_poster) if movie.last_poster
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :embeded_url
      f.input :is_featured
      f.input :approved
      f.input :actors
      f.has_many :images, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment_image attachment.object), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
    end
    f.actions
  end

end
