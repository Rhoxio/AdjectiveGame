class Character < ActiveRecord::Base

	belongs_to :user
	has_many :items
	has_one :weapon

	def attack
		self.strength + self.weapon.attack
	end

	def defend
		self.toughness
	end

	def heal
		self.faith + self.weapon.mending
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

	def exp_to_next_level
		self.experience
	end

	def level_up
		past_level = self.level
		next_level = self.level + 1

		scaling_exp = past_level * 65

		level_calculation = (next_level * 100) + scaling_exp 

		if self.experience > level_calculation
			self.level += 1
			self.experience -= level_calculation
			self.skill_points += 3
			self.save!
		else
			return false
		end
	end

	def equip_weapon(weapon)
		# Parse the JSON...
		self.weapon = Weapon.find(weapon.id)
	end

	def assign_skillpoint(attribute, amount)
		case attribute
		when 'strength'
			self.strength += amount
			self.save!
		when 'agility'
			self.agility += amount
			self.save!
		when 'intelligence'
			self.intelligence += amount
			self.save!
		when 'faith'
			self.faith += amount
			self.save!
		else
			return false
		end
	end

end
