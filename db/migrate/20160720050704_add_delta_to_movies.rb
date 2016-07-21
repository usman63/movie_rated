class AddDeltaToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :delta, :boolean, default: true, null: false
    add_index :movies, :delta
  end
end
