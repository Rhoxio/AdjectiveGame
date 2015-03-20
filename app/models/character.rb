class Character < ActiveRecord::Base

	belongs_to :user
	has_many :items

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

	def health_check
		if self.hitpoints > self.max_hitpoints
			self.hitpoints = self.max_hitpoints
		else
			return false
		end
	end

end
