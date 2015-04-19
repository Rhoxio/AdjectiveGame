class Status < ActiveRecord::Base

	def tick
		if self.duration_remaning <= 0
			return false
		else
			self.duration_remaning -= 1

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

		if roll < application chance
			return false
		else
			return true
		end
	end


end
