class Character < ActiveRecord::Base

	belongs_to :user
	has_many :items
	has_one :weapon

	def attack
		if self.weapon == true
			self.strength + self.weapon.attack
		else
			self.strength
		end
	end

	def defend(assailant, damage)
		if damage > self.toughness
			total_damage = damage - self.toughness
			self.take_damage(total_damage)
		else
			self.take_damage(0)
		end
	end

	def dodge(assailant, damage)
		diff = assailant.level - self.level
		total_dodge_chance = (self.evasion * 2) - diff
		
		if full_mitigation_check(total_dodge_chance) == true
			self.take_damage(0)
		else
			self.take_damage(damage)
			self.save
		end
	end

	def nullify(assailant, damage)
		diff = assailant.level - self.level
		total_null_chance = (self.acuity * 2) - diff

		if full_mitigation_check(total_null_chance) == true
			self.take_damage(0)
		else
			self.take_damage(damage)
			self.save
		end

	end

	def denounce(assailant, damage)
		if damage > self.piety
			total_damage = damage - self.piety
			self.take_damage(total_damage)
			self.save
		else
			self.take_damage(0)
			self.save
		end
	end

	def full_mitigation_check(chance)
		roll = rand(1..100)
		if roll > chance
			return true
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

	def take_damage(hit)
		self.hitpoints -= hit
		self.save!
	end

end
