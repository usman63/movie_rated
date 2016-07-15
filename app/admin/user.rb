ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :password

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at

  index do
    column "Images" do |m|
     image_tag(m.image.image.url(:medium)) if m.image
    end
    column :first_name
    column :last_name
    column :email
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
    end
    f.actions
  end

end
