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

						Combat::Attack.hit('one', 'two')

						ws.onopen{
							@@clients << ws
							puts "Websocket connection open with #{@@clients.length} clients."
							@@socket_state = :on
						}

						ws.onclose{
							puts "Connection closed"
							@@socket_state = :off
							@@clients.delete ws
						}

						ws.onmessage{ |msg|
							p @@socket_state

							@@clients.each do |socket|
								socket.send(msg)
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