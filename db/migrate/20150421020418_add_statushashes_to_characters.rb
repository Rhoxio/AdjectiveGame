class AddStatushashesToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :buffs, :hstore, default: {}, null: false
  	add_column :characters, :debuffs, :hstore, default: {}, null: false
  end
end
