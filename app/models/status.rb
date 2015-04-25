class Status < ActiveRecord::Base

	def tick
		if self.status_type == 'healing'
			return self.healing
		elsif self.status_type == 'damage'
			return self.damage
		else
			return 0
		end
	end

	def apply?
		roll = rand(1..100)

		if roll < self.application_chance
			return false
		else
			return true
		end
	end


end
