ActiveAdmin.register Actor do

  permit_params :name, :country, :age, :gender

  filter :movie
  filter :name
  filter :age
  filter :country
  filter :gender
  filter :date_of_birth

end
