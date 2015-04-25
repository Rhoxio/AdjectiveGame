require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

	azorius = Character.create!(name: 'Azorius', hitpoints: 10, max_hitpoints: 10, gold: 0)
	rhoxio = Character.create!(name:'Rhoxio', hitpoints: 10, max_hitpoints: 10, gold: 0)
	
	debuff = Status.create!(name: 'Poison', damage: 1, duration: 3, status_type: 'damage')
	buff = Status.create!(name: 'Renew', healing: 1, duration: 3, status_type: 'healing')

  test "that this shit is even loading correctly" do
    assert azorius
  end

  test 'characters take damage' do
  	before_hit = azorius.hitpoints
  	azorius.take_damage(1)

  	assert azorius.hitpoints < before_hit
  end

  test 'weapons may associate with characters' do
  	weapon = Weapon.create!(name: 'Zweihander')

  	azorius.weapon = weapon
  	assert azorius.weapon
  end

  test 'characters do not go over max hp when hp is restored' do
  	azorius.restore_hitpoints(1000)
  	assert azorius.hitpoints == azorius.max_hitpoints
  end

  test 'character can become debuffed' do
  	debuff = Status.create!(name: 'Poison', damage: 1, duration: 3)
  	azorius.add_debuff(debuff)
  	assert(azorius.debuffs['Poison'], '')
  end

  test 'character can become buffed' do
  	azorius.add_buff(buff)
  	assert(azorius.buffs['Renew'], '')
  end

  test 'character can mitigate all damage' do
  	assert azorius.full_mitigation_check(100)
  end

  test 'character can be hit when mitigation check fails' do
  	assert azorius.full_mitigation_check(0) == false
  end

  test 'character damage debuffs tick as expected' do
  	health_before = azorius.hitpoints

  	azorius.add_debuff(debuff)
  	azorius.tick_all_debuffs
  	assert azorius.hitpoints < health_before
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

  	assert(azorius.debuffs == {} && azorius.buffs == {})
  end

  test 'should acquire gold' do
  	azorius.acquire_gold(10)
  	assert azorius.gold == 10
  end

  test 'should give gold if character has enough' do
  	rhoxio.acquire_gold(10)
  	assert(rhoxio.gold == 10, '')
  end

  # test '' do

  # end

end
