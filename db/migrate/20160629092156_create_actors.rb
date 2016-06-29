class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name, null: false, limit:60
      t.string :country,           limit:50
      t.integer :age
      t.string :gender,            limit:10, default: "Male"
      t.date :dob

      t.timestamps null: false
    end
  end
end
