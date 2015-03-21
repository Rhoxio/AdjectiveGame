class Sorcerer < Character

	def die_roll(maximum)
		rand(1..maximum)
	end

	def stat_mod
		self.intellect + self.level
	end

	def lightning_bolt 
		self.intellect + self.weapon.attack + self.level
	end

	def firestorm
		self.intellect + self.weapon.attack
		# Apply 'Burning' debuff. Duration may be extended.
	end

end