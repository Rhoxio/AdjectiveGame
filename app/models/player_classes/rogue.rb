class Rogue < Character

	def stat_mod
		self.agility + self.level
	end

	def backstab
		# if 20_die_roll > 15
		# 	stat_mod * 2
		# else
		# 	self.agility + self.level + (self.level / 2)
		# end
	end

	def shiv
		# if 20_die_roll > 15
		# 	stat_mod
		# 	# 'Stun' effect on target for one round. Moves stunned character to top
		# 	# of turn queue after the effect ends.
		# else
		# 	stat_mod
		# end
	end

end