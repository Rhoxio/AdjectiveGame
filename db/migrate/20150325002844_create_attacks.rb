class CreateAttacks < ActiveRecord::Migration
  def change
    create_table :attacks do |t|
      t.string :name
      t.integer :character_id
      t.integer :level_requirement
      t.integer :skill_point_cost

      t.string :attack_type

      t.integer :damage
      t.integer :healing
      t.integer :critical_multiplier

      t.string :removes_status

      t.integer :accuracy
      t.boolean :always_hits
      t.boolean :true_damage

      t.integer :recharge_time

      t.timestamps null: false
    end
  end
end
