module Battle

	# class Client

	# 	attr_accessor :socket
	# 	attr_reader :name

	# 	def initialize(name, socket)
	# 		@name = name
	# 		@socket = socket
	# 	end
	# end

	# class Chat
	# 	def initialize()

	# 	end
	# end

	class BattleController < ApplicationController

		@@socket_state = :off
		@@clients = []

		# You still need to make this a helper method.
		# If the server currently has the socket 'open', then
		# do not attempt to open the socket again and simply
		# render the page. 

		def open_socket
			if @@socket_state == :off
				EventMachine.run{
					EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 9001) do |ws|

						ws.onopen{
							# Much of this will change when I get sessions up and running correctly. I just need some logic to play with right now.
							@@clients << ws
							puts "Websocket connection open with #{@@clients.length} clients."
							@@socket_state = :on
							ws.send({'action' => 'load',
											 'boss' => Character.find(5).to_json(:include => :attacks),
											 'characters' => [Character.find(1), 
																			 	Character.find(2), 
																			 	Character.find(3),
																			 	Character.find(4)],
											 'attacks' => Character.find(1).attacks}.to_json
							)}

						ws.onclose{
							puts "Connection closed"
							@@socket_state = :off
							@@clients.delete ws
						}

						# I wonder if there is a better way to delegate the flow of logic here. 
						# I initially assumed that most of it would be processed in a few of the
						# classes in the Combat module, but I think there might be a way to actually
						# change the socket object being used in certain situations. I just need 
						# to be aware of the changes being made on the front-end so the back-end
						# doesnt end up having holes.

						ws.onmessage{ |msg|
							p @@socket_state
							message = JSON.parse(msg)

							if message['action'] == 'attack'
								target = Character.find(message['target'])
								assailant = Character.find(message['assailant'])
								attack = Attack.find(message['attack'])

								resolved_target = Combat::Offense.attack_target(assailant, target, attack)

								@@clients.each do |socket|
									socket.send(resolved_target.to_json)
								end

							else
								@@clients.each do |socket|
									socket.send('Not a valid action.')
								end
							end

							puts "Recieved message: #{msg}"
							ws.send "Pong: #{msg}"
						}

						ws.onerror{|e| 
							puts "Error: #{e.message}"
						}

					end
				}
				render 'battle/battleui'
			# -------------
			else
				render 'battle/battleui'
			end
		end
	end
end