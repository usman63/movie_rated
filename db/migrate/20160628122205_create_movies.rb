class CreateMovies < ActiveRecord::Migration

  def change
    create_table :movies do |t|
      t.string :name,          null: false, limit:100
      t.date :released_date,   null: false
      t.boolean :is_featured,  null: false,           default: false
      t.text :description
      t.string :duration,                   limit:20
      t.string :embeded_url
      t.timestamps             null: false
    end
    add_index :movies, :name
    add_index :movies, :is_featured
    add_index :movies, :released_date
  end

end
