# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Brawler.create!(name: "Brawler", player_class: 'brawler', player_race: 'human', level: 1, hitpoints: 14, max_hitpoints: 14, constitution: 7, strength: 6, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Mender.create!(name: "Mender", player_class: 'mender', player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 1, agility: 1, intelligence: 2, faith: 6, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Rogue.create!(name: "Rogue", player_class: 'rogue', player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 2, agility: 6, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Sorcerer.create!(name: "Sorcerer", player_class: 'sorcerer', player_race: 'human', level: 1, hitpoints: 8, max_hitpoints: 8, constitution: 4, strength: 1, agility: 1, intelligence: 6, faith: 2, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)

Weapon.create!(name: 'Longsword', weapon_type:'sword', weight: 5, attack: 3, mending: 0, power: 0, defense: 1, avoidance: 0, resistance: 0, description: 'A basic sword for dispatching enemies. This looks to be an heirloom from times past.')
Weapon.create!(name: 'Simple Wooden Staff', weapon_type:'staff', weight: 5, attack: 0, mending: 3, power: 0, defense: 1, avoidance: 0, resistance: 0, description: 'A staff used for basic healing rituals. It is infused with some sort of energy.')
Weapon.create!(name: "Bandit's Knife", weapon_type:'dagger', weight: 3, attack: 4, mending: 0, power: 0, defense: 0, avoidance: 1, resistance: 0, description: "A useful tool for gutting someone or something. It has the initials 'HK' carved in to it.")
Weapon.create!(name: 'Simple Focus', weapon_type:'focus', weight: 3, attack: 0, mending: 0, power: 4, defense: 0, avoidance: 0, resistance: 1, description: 'A focus used to channel magical energies.')