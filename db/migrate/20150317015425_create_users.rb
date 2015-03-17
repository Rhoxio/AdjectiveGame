class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.integer :characters, :array => true
      t.integer :bosses, :array => true

      t.timestamps null: false
    end
  end
end
