class CreateImageTable < ActiveRecord::Migration

  def change
    create_table :images do |t|
      t.integer :imageable_id, null: false
      t.string  :imageable_type, null: false
      t.timestamps null: false
    end
    add_index :images, [:imageable_id,:imageable_type]
  end

end
