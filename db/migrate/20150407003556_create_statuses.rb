class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|

    	t.string :name
    	t.integer :attack_id

    	t.integer :damage
    	t.integer :healing

      t.string :status_type

      t.boolean :boss_applicable
      t.boolean :player_applicable

    	t.integer :duration
    	t.integer :duration_remaining

      t.integer :application_chance

    	t.string :effect

      t.string :dispelled_by

      t.timestamps null: false
    end
  end
end
