class AddGenreNumberToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string, limit: 30
  end
end
