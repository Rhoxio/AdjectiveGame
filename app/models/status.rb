class Status < ActiveRecord::Base

	def tick
		if self.duration_remaining <= 0
			return false
		else
			if self.damage > 0
				return self.damage
			elsif self.healing > 0
				return self.healing
			else
				return true
			end

		end
	end

	def apply?
		roll = rand(1..100)	

		if roll < application_chance
			return false
		else
			return true
		end
	end


end
