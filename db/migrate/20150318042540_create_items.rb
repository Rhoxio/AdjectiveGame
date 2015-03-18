class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.integer :weight
      t.text :description

      t.timestamps null: false
    end
  end
end
