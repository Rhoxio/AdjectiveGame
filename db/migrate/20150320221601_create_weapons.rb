class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :weapon_type
      t.integer :weight
      t.integer :character_id

      t.integer :attack
      t.integer :mending
      t.integer :power

      t.integer :defense
      t.integer :avoidance
      t.integer :resistance

      t.string :effect

      t.text :description

      t.timestamps null: false
    end
  end
end
