class Mender < Character

	def die_roll(maximum)
		rand(1..maximum)
	end

	def stat_mod
		self.faith + self.level
	end

	def heal_friend(target)
		target.heal(self.faith + self.weapon.mending)
		target.health_overflow_check
		target.save!
	end

	def exorcism
		if self.level > 3
			stat_mod
			# If player_race == 'undead', do (stat_mod + self.level) * 2
		else
			return "Not high enough level to cast this spell..."
		end
	end

	def smite
		self.faith + self.weapon.attack
	end

end