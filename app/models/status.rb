class Status < ActiveRecord::Base

	def tick
		if self.duration_remaning <= 0
			0
		else
			self.duration_remaning -= 1
			return self.damage
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
