class Brawler < Character

	def stat_mod
		self.strength + self.level
	end

	def mortal_strike
		# Apply 'Mortal Strike' debuff. 
		self.strength + self.weapon.attack + self.level
	end

	def selfless_defense(target)
		# Needs to parse target from JSON. 
		target = Character.find(target.id)
		if target.player_class != 'boss'
			# Give that player a buff that halves damage taken from next attack.
			return true
		else
			return true
			# Reduces the damage the boss(es) take by a flat amount based on level and toughness.
		end
	end

end