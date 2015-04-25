require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

	azorius = Character.create!(name: 'Azorius', hitpoints: 10, max_hitpoints: 10, gold: 0)
	rhoxio = Character.create!(name:'Rhoxio', hitpoints: 10, max_hitpoints: 10, gold: 0)
	
	debuff = Status.create!(name: 'Poison', damage: 1, duration: 3, status_type: 'damage')
	buff = Status.create!(name: 'Renew', healing: 1, duration: 3, status_type: 'healing')

  test 'characters take damage' do
  	before_hit = azorius.hitpoints
  	azorius.take_damage(1)

  	assert(azorius.hitpoints < before_hit, 'Character did not take damage.')
  end

  test 'weapons may associate with characters' do
  	weapon = Weapon.create!(name: 'Zweihander')

  	azorius.weapon = weapon
  	assert(azorius.weapon, 'Character model does not associate weapons with itself')
  end

  test 'characters do not go over max hp when hp is restored' do
  	azorius.restore_hitpoints(1000)
  	assert(azorius.hitpoints == azorius.max_hitpoints, 'Characters hp did not stop at max, or the object used has over 1000 hp')
  end

  test 'character can become debuffed' do
  	debuff = Status.create!(name: 'Poison', damage: 1, duration: 3)
  	azorius.add_debuff(debuff)
  	assert(azorius.debuffs['Poison'], 'Debuff did not apply')
  end

  test 'character can become buffed' do
  	azorius.add_buff(buff)
  	assert(azorius.buffs['Renew'], 'Buff did not apply')
  end

  test 'character can mitigate all damage' do
  	assert(azorius.full_mitigation_check(100), 'Character did not mitigate damge at 100% chance.')
  end

  test 'character can be hit when mitigation check fails' do
  	refute(azorius.full_mitigation_check(0), 'Move still resolved to true.')
  end

  test 'character damage debuffs tick as expected' do
  	health_before = azorius.hitpoints

  	azorius.add_debuff(debuff)
  	azorius.tick_all_debuffs
  	assert(azorius.hitpoints < health_before, "Damage debuffs didn't tick correctly")
  end

  test 'character healing buffs tick as expected' do
  	azorius.hitpoints = 5
  	health_before = azorius.hitpoints

  	azorius.add_buff(buff)
  	azorius.tick_all_buffs
  	assert(azorius.hitpoints > health_before, 'Buffs failed to update healing')
  end

  test 'should clear all statuses' do
  	azorius.add_debuff(debuff)
  	azorius.add_buff(buff)
  	azorius.clear_statuses

  	assert(azorius.debuffs == {} && azorius.buffs == {}, 'Debuffs did not clear correctly.')
  end

  test 'should acquire gold' do
  	azorius.acquire_gold(10)
  	assert(azorius.gold == 10, 'Character did not acquire gold')
  end

  test 'should give gold if character has enough' do
  	rhoxio.acquire_gold(10)
  	assert(rhoxio.gold == 10, 'Character did not give up gold')
  end

  test 'character should be alive with more than 1 hp' do
  	azorius.hitpoints = 1
  	assert(azorius.alive?, 'Character is not alive even though their hp is over 0.')
  end

  test 'character should be dead with 0 or less than 0 hp.' do
  	azorius.hitpoints = 0
  	refute(azorius.alive?, 'Character did not register as dead even though hp was 0.')
  end

end
