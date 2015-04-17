class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|

    	t.string :name
    	t.integer :attack_id

    	t.integer :damage
    	t.integer :healing

    	t.integer :duration
    	t.integer :duration_remaining

    	t.integer :application_chance

    	t.string :effect

      t.timestamps null: false
    end
  end
end
