class Character < ActiveRecord::Base

	belongs_to :user
	has_many :items
	has_many :attacks
	has_one :weapon

	# def attack
	# 	# Needs to be rewritten, as I don't use this model for damage any more. 
	# 	if self.weapon == true
	# 		self.strength + self.weapon.attack
	# 	else
	# 		self.strength
	# 	end
	# end

# Defensive Abilities
	def defend(assailant, attack)
		diff = assailant.level - self.level

		if attack.attack_type == 'physical'
			total_damage_defended = self.toughness - diff
			if total_damage_defended < 0
				total_damage_defended = 0
				return total_damage_defended
			else
				return total_damage_defended
			end
		else
			return 0
		end

	end

	def dodge?(assailant, attack)
		diff = assailant.level - self.level
		total_dodge_chance = (self.evasion * 2) - diff
		
		if attack.attack_type == 'physical'
		 full_mitigation_check(total_dodge_chance)
		else
			return false
		end
	end

	def nullify?(assailant, attack)
		diff = assailant.level - self.level
		total_null_chance = (self.acuity * 2) - diff

		if attack.attack_type == 'elemental'
			full_mitigation_check(total_null_chance)
		else
			return false
		end
	end

	def denounce(assailant, attack)
		diff = assailant.level - self.level

		if attack.attack_type == 'divine'
			total_damage_defended = self.toughness - diff
			if total_damage_defended < 0
				total_damage_defended = 0
				return total_damage_defended
			else
				return total_damage_defended
			end
		else
			return 0
		end
	end

# Combat Utility

	def take_damage(hit)
		if hit > 0
			self.hitpoints -= hit
			p "#{self.name} took #{hit} damage!"
		else
			p "#{self.name} took no damage!"
		end
		self.save!
	end

	def full_mitigation_check(chance)
		roll = rand(1..100)
		if roll < chance
			return true
		else
			return false
		end
	end

# Status Updates / Checks

	def alive?
		if self.hitpoints > 0
			return true
		else
			return false
		end
	end

	def health_overflow_check
		if self.hitpoints > self.max_hitpoints
			self.hitpoints = self.max_hitpoints
			self.save!
		else
			return false
		end
	end

	def heal
		if self.weapon == true
			self.hitpoints += (self.faith + self.weapon.mending)
			health_overflow_check
			self.save!
		else
			self.hitpoints += self.faith
			health_overflow_check
			self.save!
		end
	end

# Status Handlers

	# I need to somehow keep track of the current buff/debuff
	# stats that are given or taken by the buff/debuffs themselves.

	# I could potentially just make some variables on this model
	# and have the buff/debuff_timer_rotation return a hash where
	# keys act as identifiers for the effect, values are the total_damage or booleans for 
	# the stun/paralyze/confuse effect. They will be be calculated in the Combat::State module. 

	def add_debuff(status)
		self.debuffs << status
	end

	def add_buff(buff)
		self.buffs << buff
	end

	def debuff_timer_rotation
		debuff_actions = {}

		self.debuffs.each do |status|
			if status.duration_remaining <= 0
				status.delete
			else
				debuff_actions[status.effect] = :active
				status.tick
			end
		end

		return debuff_actions
	end

	def buff_timer_rotation
		buff_actions = {}

		self.buffs.each do |buff|
			if buff.duration_remaining <= 0
				buff.delete
			else
				buff_actions[buff.effect] = :active
				buff.tick
			end
		end

		return buff_actions

	end

# Utility Calculation Methods

	def level_calculation
		next_level = self.level + 1
		scaling_exp = past_level * 65

		level_calculation = (next_level * 100) + scaling_exp
		return level_calculation
	end

	def exp_to_next_level
		self.level_calculation - self.experience
	end

	def level_up
		if self.experience > self.level_calculation
			self.level += 1
			self.experience -= self.level_calculation
			self.skill_points += 3
			self.save!
		else
			return false
		end
	end

# Equipment Logic

	def equip_weapon(weapon)
		# Parse the JSON before this...
		self.weapon = Weapon.find(weapon.id)
	end

	def assign_skillpoint(attribute, amount)
		case attribute
		when 'strength'
			self.strength += amount
		when 'agility'
			self.agility += amount
		when 'intelligence'
			self.intelligence += amount
		when 'faith'
			self.faith += amount
		else
			return false
		end
		self.save!
	end

# Currency Logic

	def acquire_gold(amount)
		self.gold += amount
		self.save!
	end

	def give_gold(amount)
		if self.gold > amount
		 	self.gold -= amount
		 	self.save!
		else
			false
		end
	end



end
