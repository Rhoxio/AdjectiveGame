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

	class Attack

	 	def self.attack_target(assailant, target, attack)
	 		# @assailant = Character.find(assailant.id)
	 		# @target = Character.find(target.id)
	 		# @attack = Attack.find(attack.id)

	 		hit_roll = rand(attack.accuracy..100)
	 		critical_strike = false

	 		target_damage_mitigation = mitigation_check(assailant, target, attack)

	 		if target_damage_mitigation['dodge'] == true || target_damage_mitigation['nullify'] == true 
	 			target.take_damage(0)
	 			target.save
	 			return target
	 		end

	 		if hit_roll >= 100 || attack.always_hits
	 			total_mititgation = target_damage_mitigation['defend'] + target_damage_mitigation['denounce']
	 			target.take_damage(attack.damage - total_mititgation)
	 			target.save
	 			return target
	 		end

	 		# @target.take_damage(attack.damage)
	 		# Roll on-hit chance.
	 		# Return an object that will help the DOM render.
	 	end

	 	def mitigation_check(assailant, character, attack)
	 		evasion_hash = {}

	 		evasion_hash['defend'] = character.defend(assailant, attack)
	 		evasion_hash['dodge'] = character.dodge(assailant, attack)
	 		evasion_hash['nulifly'] = character.nullify(assailant, attack)
	 		evasion_hash['denounce'] = character.denounce(assailant, attack)

	 		return evasion_hash
	 	end

	 	def self.miss(target, attack)
	 		# @target = Class.find(target.id)
	 		# @target.take_damage(0)
	 		# Return an object that lets the DOM render a miss. Should
	 		# be fundamenally different from taking zero damage. 
	 	end

	 	def self.resist(target, attack)
	 		# @target = Class.find(target.id)
	 		# total_damage = @target.applicable_resistance - attack.damage
	  end

	  def self.dodge(target, attack)
	  	# @target = Class.find(target.id)
	  	# did_it_miss? = @target.dodge_method
	  end

	end

 class Defend

 end


end