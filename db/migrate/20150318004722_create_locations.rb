class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :background_path
      t.string :coordinates, :array => true

      t.integer :enemy_types, :array => true
      t.integer :npc_types, :array => true
      t.integer :shop_types, :array => true

      t.timestamps null: false
    end
  end
end
