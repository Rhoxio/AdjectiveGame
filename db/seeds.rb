# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Mender.create!(name: "Mender", player_class: 'mender', player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 1, agility: 1, intelligence: 2, faith: 6, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Brawler.create!(name: "Brawler", player_class: 'brawler', player_race: 'human', level: 1, hitpoints: 14, max_hitpoints: 14, constitution: 7, strength: 6, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Rogue.create!(name: "Rogue", player_class: 'rogue', player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 2, agility: 6, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Sorcerer.create!(name: "Sorcerer", player_class: 'sorcerer', player_race: 'human', level: 1, hitpoints: 8, max_hitpoints: 8, constitution: 4, strength: 1, agility: 1, intelligence: 6, faith: 2, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)

