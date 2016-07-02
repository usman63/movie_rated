class AddIsFeaturedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :featured, :boolean, default: false, index: true
  end
end
