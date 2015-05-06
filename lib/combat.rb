module Combat

	# INITIAL: You may just want this module to do all of the calculations for you
	# and simply return the damage and status effect as an object.

		# EDIT 1: I feel as if I need to run the calculations through this module in order to keep
	 	# the flow of data more consistent in the websockets. Considering the socket-objects themselves
	 	# hold the 'pointer' to sending the information out, it makes no sense to run logic through
	 	# the models themsevles if I plan on making the engine itself adaptable to change down the road.

	 		# EDIT 2: I think I was wrong about this. As long as the code below the surface returns full objects
	 		# to be sent, you don't need anything else. Much of the logic pertaning to the objects themselves can be calculated
	 		# on the model, and the interaction between objects should be run through this module based on the
	 		# action sent to the server. 


	# For example:

	# If the server recieved an 'attack' action:
		# Combat::Offense.method(assailant, target, attack) -> {target => ammended_target_object, miss? => true/false, x => y} etc.

	# ------

	# I think I am building this right. I have been making attempts to keep most of the logic that involves multiple objects 
	# out of the ActiveRecord models (unless the object is associated with the parent object, of course). 
	# This module circumvents that problem and independently modifies the objects
	# using methods and accessors on the object itself. This is clean OO, as far as I know. 

	# It always 'asks' and never demands or forces something to change.  

	class Offense

	 	def self.attack_target(assailant, target, attack)
	 		# This thing is becoming a god object. I need to think about breaking this logic up in to
	 		# smaller chunks of logic later. It will help with the logic on the controller later, too. 

	 		hit_roll = rand(1..100)
	 		critical_strike = self.critical_strike?(assailant, attack)

	 		target_damage_mitigation = Defense.mitigation_check(assailant, target, attack)
	 		target_passed_evasion_check = self.hit_target?(target_damage_mitigation)


	 		if target_passed_evasion_check && attack.always_hits == false
	 		 # If false, the attack 'misses' or does not always hit, they take 0 damage. I do this because
	 		 # there may be things later that update on attack/defend. I don't see how it could
	 		 # cause problems immediately, so I'll leave it.

	 		 # EDIT: Maybe I should have the object and/or data set returned have some sort of attribute that explicity states that this was
	 		 # a miss as opposed to simply taking zero damage. There is going to have to be some coupling between the front and back 
	 		 # if I do this, but it's really no more than if I had an object with specifically named attributes anyway. 
	 		 # If I have this return a hash, I could easily just take the hash value for 'missed?' or something like that.

	 			target.take_damage(0)
	 			target.save
	 			return target
	 		elsif hit_roll < attack.accuracy || attack.always_hits

	 			# Considering I am using an integer of 100 as the base meter for hit percentage, if they roll
	 			# a value lower than the attack's accuracy atribute, then they score a hit. The misses happen when they roll a value
	 			# higher than the hit_roll. Same probability, just a lot less logic to handle.

	 			# Even though attacks do not have multiple types to mititgate damage from (yet), this implementation
	 			# is both a clean and flexible way of dealing with those values. This works because when the
	 			# target_damage_mititgation is calculated, it accounts for the attack's type as well.

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
	 			p 'Something might be missing an attribute. Hopefully your tests caught this...'
	 			return target
	 		end

	 		# Return an object that will help the DOM render. 
	 	end

	 	# Might be able to stick this logic on the model somehow. I am still a little skeptical about
	 	# placing this in this module... I will have to have Scott look at it. 
	 	def self.hit_target?(mitigation_hash)
	 		if mitigation_hash['defend'] == true || mitigation_hash['nullify'] == true
	 			return false
	 		else
	 			return true
	 		end
	 	end

	 	def self.critical_strike?(assailant, attack)
	 		roll = rand(1..100)
	 		# total_crit_chance defaults to 10%. 
	 		total_crit_chance = assailant.agility + 10

	 		if total_crit_chance > 70
	 			# Having attacks always critically hit is unhealthy; especially if they have a multipler over 150%.
	 			# 70% is a good standard to live by in most cases.
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

 		# INITIAL: The main issue that I am running to is figuring out how I want to actually 
 		# get the numbers off of the database. I think I am simply going to save the 
 		# status IDs in the debuffs/buffs arrays and just each over them and use .find(num)
 		# to get their data off of the database. This is slower than hashing, but it would be a lot easier.

	 		# EDIT: I ended up moving a lot of the logic over to the models. This module should be used
	 		# as a way to structure 'tasks' that are delegated on the model's methods. Most of the logic itself gets
	 		# calculated here, but the values that get returned from the model is the stuff that is needed
	 		# to update the models accordingly as well as output updated models.to_json for the controller to send.

	 		# EDIT 2, FOR GREAT JUSTICE: I actually ended up using hstore in ActiveRecord to persist hashes so I just have to call an attribute
	 		# on an instance of a model to get the hash that I need. Easy!

 		# Fat model, skinny controller. 

 		def self.tick_all_statuses(characters)
 			characters.each {|character| character.tick_all_buffs}
 			characters.each {|character| character.tick_all_debuffs}
 		end

 		def self.apply_status(assailant = nil, target, attack)
 			# The variable 'assailant' is a placeholder for model attribute comparisons later. Might or might not use it. This is mainly to keep things
 			# as consistent as possible when running logic through the class methods in this module.

 			# Something else to note is that I decided to associate status effects on attacks. This way, I have the ability
 			# to implement more than one type of funtionality per instance of a model. This also allows me to easily implement 
 			# logic to calculate all of the damage and individual effects in a more straightforward manner. 
 			status = attack.status

 			# YOU DONT NEED TO WORRY ABOUT THE DAMAGE/HEALING THE STATUSES DO. IT IS GENERATED ALONG WITH THEM WHEN THE DB GETS SEEDED.
 			if status.status_type == 'healing'
 				target.add_buff(status)
 				target.save
 			elsif status.status_type == 'damage'
 				target.add_debuff(status)
 				target.save
 			else
 				return false
 			end
 		end

 		def self.remove_status(assailant = nil, target, attack)
 			# assailant is a placeholder for complex logic later. Might or might not use it.

 			# I could have nested the if statements here and removed the logical 'and' for each case. I decided that nested
 			# loops tend to lead to problems with performance and clarity, so I figured checking two booleans per operation would work
 			# better. 

 			# It may seem like calling these attributes from the attack object itself is not clean, it is best to remember that the hash 
 			# construced or ammended when a status is applied automatically uses the 'name' attribute on the status object as a key.
 			# This means that each removal type attack will need to have a perfectly matching string in order to work, that is of much less 
 			# consequence in the long run considering how the moves will have to be generted by hand.  
 			if attack.attack_type == 'healing' && target.debuffs[attack.removes_status] != nil
 				target.remove_debuff(attack.removes_status)
 			elsif attack.attack_type == 'healing' && target.buffs[attack.removes_status] != nil
 				target.remove_buff(attack.removes_status)
 			else
 				return false
 			end
 			target.save!
 		end



 	end

end















