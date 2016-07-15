ActiveAdmin.register Movie do

  permit_params :name, :description, :embeded_url, {actor_ids: []}, :featured, images_attributes: [:id, :image, :_destroy]

  filter :name
  filter :featured
  filter :actors
  filter :released_date

  show do
    panel "Movie" do
      table_for movie do
        column :name
        column :description
        column :embeded_url
        column :featured
        column :actors do |movie|
          movie.cast
        end
        column "Image" do |m|
            m.images.each do |attachment|
              div do
                image_tag(attachment.image.url(:medium)) if attachment.image
              end
            end
        end
      end
    end
  end

  index do
    column :name
    column :description
    column :embeded_url
    column :featured
    column :actors do |movie|
      movie.cast
    end
    column "Image" do |m|
      image_tag(m.last_poster.image.url(:medium)) if m.last_poster
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :embeded_url
      f.input :featured
      f.input :actors
      f.has_many :images, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:medium)), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
    end
    f.actions
  end

end
