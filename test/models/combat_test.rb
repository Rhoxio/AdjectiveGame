require 'test_helper'

class CombatTest < ActiveSupport::TestCase
	attacker = Character.create!(name: "Attacker", player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 7, strength: 1, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)
	defender = Character.create!(name: "Defender", player_race: 'human', level: 1, hitpoints: 10, max_hitpoints: 10, constitution: 7, strength: 1, agility: 1, intelligence: 1, faith: 1, toughness: 1, evasion: 1, acuity: 1, piety: 1, initiative: 1, hit_chance: 100)

	normal_attack = Attack.create!(name: 'Attack', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 1, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)
	poison_attack = Attack.create!(name: 'Attack', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 1, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)
	true_damage_attack = Attack.create!(name: 'Attack', level_requirement: 1, skill_point_cost: 0, attack_type: 'physical', damage: 1, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: true, recharge_time: 0)


	renew = Attack.create!(name: 'Attack', level_requirement: 1, skill_point_cost: 0, attack_type: 'healing', damage: 0, critical_multiplier: 150, accuracy: 100, always_hits: false, true_damage: false, recharge_time: 0)

	cleanse = Attack.create!(name: 'Cleanse', level_requirement: 1, skill_point_cost: 0, attack_type: 'healing', damage: 0, critical_multiplier: 0, accuracy: 100, always_hits: true, true_damage: false, recharge_time: 0, removes_status: 'Poison')
	heal = Attack.create!(name: 'Cleanse', level_requirement: 1, skill_point_cost: 0, attack_type: 'healing', damage: 0, healing: 1, critical_multiplier: 0, accuracy: 100, always_hits: true, true_damage: false, recharge_time: 0)
	dispell = Attack.create!(name: 'Dispell', level_requirement: 1, skill_point_cost: 0, attack_type: 'healing', damage: 0, healing: 1, critical_multiplier: 0, accuracy: 100, always_hits: true, true_damage: false, recharge_time: 0, removes_status: 'Renew')

	poison = Status.create!(name: 'Poison', attack_id: nil, damage: 1, healing: 0, boss_applicable: true, player_applicable: true, duration: 3, duration_remaining: 3, status_type: 'damage', application_chance: 100, effect: 'poison' )
	renew_status = Status.create!(name: 'Renew', attack_id: nil, damage: 0, healing: 1, boss_applicable: true, player_applicable: true, duration: 3, duration_remaining: 3, status_type: 'healing', application_chance: 100, effect: 'heal' )

	poison_attack.status = poison
	renew.status = renew_status

	# Status Tests

	test 'should apply a status to a character' do
		Combat::Status.apply_status(attacker, defender, poison_attack)

		assert(defender.debuffs['Poison'], 'Status did not apply.')
	end

	test 'should remove debuff from a character' do
		defender.clear_statuses
		Combat::Status.apply_status(attacker, defender, poison_attack)

		Combat::Status.remove_status(attacker, defender, cleanse)

		assert(defender.debuffs == {}, "Did not remove the debuff: #{defender.debuffs}")
	end

	test 'should remove buff from a character' do
		defender.clear_statuses
		Combat::Status.apply_status(attacker, defender, renew)

		Combat::Status.remove_status(attacker, defender, dispell)

		assert(defender.buffs == {}, "Did not remove the buff: #{defender.buffs}")
	end

	test 'should return true when an attack is dodged' do
		defender.evasion = 100
		defense_hash = Combat::Defense.mitigation_check(attacker, defender, normal_attack)
		assert(Combat::Offense.hit_target?(defense_hash), 'Did not dodge the attack.')
	end

	test 'should not critically hit if an attack does true damage' do
		assert(Combat::Offense.critical_strike?(attacker, true_damage_attack) == false, 'Critical strikes happen on true damage attacks.')
	end

end









