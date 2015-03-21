class Rogue < Character

	def die_roll(maximum)
		rand(1..maximum)
	end

	def stat_mod
		self.agility + self.level
	end

	def backstab
		if die_roll(20) > 15
			stat_mod * 2
		else
			self.agility + self.level + (self.level / 2)
		end
	end

	def shiv
		if die_roll(20) > 15
			stat_mod
			# 'Stun' effect on target for one round. Moves stunned character to top
			# of turn queue after the effect ends.
		else
			stat_mod
		end
	end

end