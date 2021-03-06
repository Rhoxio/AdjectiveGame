Character.create!(name: "Brawler", player_race: 'human', level: 1, hitpoints: 14, max_hitpoints: 14, constitution: 7, strength: 6, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Character.create!(name: "Mender", player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 1, agility: 1, intelligence: 2, faith: 6, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Character.create!(name: "Rogue", player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 5, strength: 2, agility: 6, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
Character.create!(name: "Sorcerer", player_race: 'human', level: 1, hitpoints: 8, max_hitpoints: 8, constitution: 4, strength: 1, agility: 1, intelligence: 6, faith: 2, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)

Character.create!(name: "Boss Man", player_race: 'orc', level: 5, hitpoints: 100, max_hitpoints: 100, constitution: 7, strength: 6, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100, boss: true)

Weapon.create!(name: 'Longsword', weapon_type:'sword', weight: 5, attack: 3, mending: 0, power: 0, defense: 1, avoidance: 0, resistance: 0, description: 'A basic sword for dispatching enemies. This looks to be an heirloom from times past.')
Weapon.create!(name: 'Simple Wooden Staff', weapon_type:'staff', weight: 5, attack: 0, mending: 3, power: 0, defense: 1, avoidance: 0, resistance: 0, description: 'A staff used for basic healing rituals. It is infused with some sort of energy.')
Weapon.create!(name: "Bandit's Knife", weapon_type:'dagger', weight: 3, attack: 4, mending: 0, power: 0, defense: 0, avoidance: 1, resistance: 0, description: "A useful tool for gutting someone or something. It has the initials 'HK' carved in to it.")
Weapon.create!(name: 'Simple Focus', weapon_type:'focus', weight: 3, attack: 0, mending: 0, power: 4, defense: 0, avoidance: 0, resistance: 1, description: 'A focus used to channel magical energies.')

Attack.create!(name: 'Attack', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 1, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)
Attack.create!(name: 'Bash', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 2, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)
Attack.create!(name: 'Exorcism', level_requirement: 1, skill_point_cost: 0, attack_type: 'divine', damage: 2, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: true, recharge_time: 0)
Attack.create!(name: 'Fireball', level_requirement: 1, skill_point_cost: 0, attack_type: 'elemental', damage: 3, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)
Attack.create!(name: 'Shank', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 2, critical_multiplier: 200, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)

Attack.create!(name: 'Cleanse', level_requirement: 1, skill_point_cost: 0, attack_type: 'healing', damage: 0, critical_multiplier: 0, accuracy: 100, always_hits: true, true_damage: false, recharge_time: 0, removes_status: 'Weak Poison')

Status.create!(name: 'Weak Poison', attack_id: 5, damage: 1, healing: 0, boss_applicable: true, player_applicable: true, duration: 3, duration_remaining: 3, status_type: :damage, application_chance: 100, effect: :poison, dispelled_by: 'antidote' )
Status.create!(name: 'Renew', attack_id: 5, damage: 0, healing: 1, boss_applicable: true, player_applicable: true, duration: 3, duration_remaining: 3, status_type: :healing, application_chance: 100, effect: :poison, dispelled_by: 'dispell magic' )



brawler = Character.find(1).weapon = Weapon.find(1)
mender = Character.find(2).weapon = Weapon.find(2)
rogue = Character.find(3).weapon = Weapon.find(3)
sorcerer = Character.find(4).weapon = Weapon.find(4)

char = Character.find(1)
boss = Character.find(5)


char.attacks << Attack.find(1) << Attack.find(2) << Attack.find(3)
boss.attacks << Attack.find(1) << Attack.find(2) << Attack.find(3)
# brawler.weapon = Weapon.find(1)














