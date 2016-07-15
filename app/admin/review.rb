ActiveAdmin.register Review do

  actions :all, except: [:new]

  filter :review
  filter :report_count
  filter :created_at
  filter :review
  filter :id
  filter :movie
  filter :user_id, as: :select, collection: User.pluck(:email, :id)

  index do
    column :id
    column :review
    column :report_count
    column :user
    column :movie
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.pluck(:email, :id), input_html: { :disabled => true }
      f.input :movie, input_html: { :disabled => true }
      f.input :review
    end
    f.actions
  end

end
