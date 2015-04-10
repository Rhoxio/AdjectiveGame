module Combat

	# You may just want this module to do all of the calculations for you
	# and simply return the damage and status effect as an object.

	# I feel as if I need to run the calculations thorugh this module in order to keep
 	# the flow of data more consistent in the websockets. Considering the socket-objects themselves
 	# hold the 'pointer' to sending the information out, it makes no sense to run logic through
 	# the models themsevles if I plan on making the engine itself as dynamic as possible. 

 	# It will be executed by passing objects in to the Combat module's class that corresponds to the action
 	# sent to the server by the client. This also means that you can potentially import new functionality
 	# or balance simply by changing the attack values. This also leaves much of the code more 
 	# decoupled, but still requires a processing module. 

	# Combat::Attack.method
	# Combat::Defend.method

	class Offense

	 	def self.attack_target(assailant, target, attack)
	 		# The assailant is only needed to pass in to the methods on the model. 

	 		hit_roll = rand(attack.accuracy..100)
	 		critical_strike = false

	 		target_damage_mitigation = Defense.mitigation_check(assailant, target, attack)
	 		p target_damage_mitigation

	 		if target_damage_mitigation['dodge'] == true || target_damage_mitigation['nullify'] == true 
	 			target.take_damage(0)
	 			target.save
	 			return target
	 		elsif hit_roll >= 100 || attack.always_hits
	 			total_mititgation = target_damage_mitigation['defend'] + target_damage_mitigation['denounce']
	 			target.take_damage(attack.damage - total_mititgation)
	 			target.save
	 			return target
	 		end

	 		# @target.take_damage(attack.damage)
	 		# Roll on-hit chance.
	 		# Return an object that will help the DOM render.
	 	end


	end

 class Defense

 		 	def self.mitigation_check(assailant, character, attack)
	 		evasion_hash = {}

	 		if attack.true_damage
	 			evasion_hash['defend'] = 0
		 		evasion_hash['dodge'] = character.dodge?(assailant, attack)
		 		evasion_hash['nullifly'] = character.nullify?(assailant, attack)
		 		evasion_hash['denounce'] = 0
		 		return evasion_hash
	 		else
		 		evasion_hash['defend'] = character.defend(assailant, attack)
		 		evasion_hash['dodge'] = character.dodge?(assailant, attack)
		 		evasion_hash['nullifly'] = character.nullify?(assailant, attack)
		 		evasion_hash['denounce'] = character.denounce(assailant, attack)
		 		return evasion_hash
		 	end

	 	end

 end


end

