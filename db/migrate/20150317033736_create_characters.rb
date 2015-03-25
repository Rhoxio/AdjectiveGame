class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :player_class
      t.string :player_race
      t.integer :level

      t.integer :experience
      t.integer :skill_points
      
      t.integer :gold

      t.integer :user_id

      t.integer :hitpoints
      t.integer :max_hitpoints

      # Constitution directly effects health modifiers
      t.integer :constitution

      # Base stats directly influence class modifiers
      t.integer :strength
      t.integer :agility
      t.integer :intelligence
      t.integer :faith

      # Evasion stats are influenced by constitution AND base stats.
      t.integer :toughness
      t.integer :evasion
      t.integer :acuity
      t.integer :piety

      # Percentage based on agility, modifier based on highest stat other than Agi.
      t.integer :critical_chance
      t.integer :critical_modifier

      # Speed. Will control turn-based mechanics.
      t.integer :initiative

      # As the name implies. All characters will start with 100%, modified by status, weapons, spells, etc 
      # before damage calculations in fights. 
      t.integer :hit_chance

      # Will be run through helper methods to calculate effects.
      t.string :debuffs, :array => true
      t.string :buffs, :array => true

      t.timestamps null: false
    end
  end
end
