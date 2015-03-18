class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :coordinates, :array => true
      t.integer :enemy_types

      t.timestamps null: false
    end
  end
end
