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

	 		hit_roll = rand(1..100)
	 		critical_strike = self.critical_strike?(assailant, attack)

	 		target_damage_mitigation = Defense.mitigation_check(assailant, target, attack)

	 		if target_damage_mitigation['dodge'] == true || target_damage_mitigation['nullify'] == true 
	 			target.take_damage(0)
	 			target.save
	 			return target
	 		elsif hit_roll < attack.accuracy || attack.always_hits
	 			total_mitigation = target_damage_mitigation['defend'] + target_damage_mitigation['denounce']

	 			if critical_strike
	 				total_damage = ((attack.damage - total_mitigation) * attack.critical_multiplier).round
	 				target.take_damage(total_damage)
	 			else
	 				target.take_damage(attack.damage - total_mitigation)
	 			end

	 			target.save
	 			return target
	 		else
	 			return target
	 		end

	 		# @target.take_damage(attack.damage)
	 		# Roll on-hit chance.
	 		# Return an object that will help the DOM render.
	 	end

	 	def self.critical_strike?(assailant, attack)
	 		roll = rand(1..100)
	 		total_crit_chance = assailant.agility + 10

	 		if total_crit_chance > 70
	 			total_crit_chance = 70
	 			critical_threshold = 100 - total_crit_chance
	 		else
	 			critical_threshold = 100 - total_crit_chance
	 		end

	 		if attack.true_damage
	 			return false
	 		elsif roll > critical_threshold
	 			return true
	 		else
	 			return false
	 		end 
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

 	class Status

 		def self.tick_all_statuses(characters)

 			characters.each do |character|

 				character.debuffs.each do |debuff_id|

 					current_debuff = Status.find(debuff_id)

 					if current_debuff.status_type == :damage
 						character.take_damage(current_debuff.tick)
 						character.save
 					elsif current_debuff.status_type == :healing
 						character.restore_hitpoints(current_debuff.tick)
 						character.save
 					else
 						debuff.tick
 					end
 				end

				character.buffs.each do |buff_id|

					current_buff = Status.find(buff_id)

					if current_buff.status_type == :damage
						character.take_damage(current_buff.tick)
						character.save
					elsif current_buff.status_type == :healing
						character.restore_hitpoints(current_buff.tick)
						character.save
					else
						buff.tick
					end
				end
	 		end
 		end

 		# The main issue that I am running to is figuring out how I want to actually 
 		# get the numbers off of the database. I think I am simply going to save the 
 		# status IDs in the debuffs/buffs arrays and just each over them and use .find(num)
 		# to get their data off of the database. This is slower than hashing, but it would be a lot easier.

 		def self.apply_status(assailant, target, attack)

 		end


 	end

end















