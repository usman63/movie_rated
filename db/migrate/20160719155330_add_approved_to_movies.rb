class AddApprovedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :approved, :boolean
    add_index :movies, :approved
  end
end
