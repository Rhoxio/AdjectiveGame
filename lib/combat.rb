module Combat

	# You may just want this module to do all of the calculations for you
	# and simply return the damage and status effect as an object.

	# I feel as if I need to run the calculations thorugh this module in order to keep
 	# the flow of data more consistent in the websockets. Considering the socket-objects themselves
 	# hold the 'pointer' to sending the information out, it makes no sense to run logic through
 	# the models themsevles if I plan on making the engine itself as dynamic as possible.

 		# EDIT: I think I was wrong about this. As long as the code below the surface returns full objects
 		# to be sent, you don't need anything else. 

 	# It will be executed by passing objects in to the Combat module's class (Combat::Defense, Combat::Offense)
 	# that corresponds to the action sent to the server by the client. 

	# Combat::Attack.method
	# Combat::Defend.method

	# ------
	# I think I am building this right. I have been making attempts to keep most of the logic out of the ActiveRecord models.
	# The models change themselves when asked to, but I need to be careful with what they return. Some stray hash value
	# could crash something, or do something really funky. 

	class Offense

	 	def self.attack_target(assailant, target, attack)
	 		# This thing is becoming a god object. I need to think about breaking this logic up in to
	 		# smaller chunks of logic later. It will help with the logic on the controller later, too. 

	 		hit_roll = rand(1..100)
	 		critical_strike = self.critical_strike?(assailant, attack)

	 		target_damage_mitigation = Defense.mitigation_check(assailant, target, attack)

	 		if target_damage_mitigation['dodge'] == true || target_damage_mitigation['nullify'] == true
	 		 # Could put this logic on the model. 
	 			target.take_damage(0)
	 			target.save
	 			return target
	 		elsif hit_roll < attack.accuracy || attack.always_hits
	 			# Eew, nested if. Pull this out in to another method somehow. 
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
 			characters.each {|character| character.tick_all_buffs}
 			characters.each {|character| character.tick_all_debuffs}
 		end

 		# The main issue that I am running to is figuring out how I want to actually 
 		# get the numbers off of the database. I think I am simply going to save the 
 		# status IDs in the debuffs/buffs arrays and just each over them and use .find(num)
 		# to get their data off of the database. This is slower than hashing, but it would be a lot easier.

	 		# EDIT: I ended up moving a lot of the logic over to the models. This module should be used
	 		# as a way to structure 'tasks' that are delegated on the model's logic. Most of the logic itself gets
	 		# calculated here, but the values that get returned from the model is the stuff that is needed
	 		# to update the models accordingly as well as output updated models.to_json for the sockets to send.

 		# Fat model, skinny controller. 

 		def self.apply_status(assailant, target, attack)
 			status = attack.status

 			# YOU DONT NEED TO WORRY ABOUT THE DAMAGE THE STUPID DEBUFFS DO. IT IS ON THEIR MODEL.
 			if status.status_type == :healing
 				target.add_buff(status)
 				target.save
 			elsif status.status_type == :damage
 				target.add_debuff(status)
 				target.save
 			else
 				return false
 			end
 		end


 	end

end















