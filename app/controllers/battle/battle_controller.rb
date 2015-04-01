module Battle
	class BattleController < ApplicationController

		@@socket_state = :off

		# You still need to make this a helper method.
		# If the server currently has the socket 'open', then
		# do not attempt to open the socket again and simply
		# render the page. 

		def open_socket
			if @@socket_state == :off
				EventMachine.run{
					EventMachine::WebSocket.start(:host => 'localhost', :port => 9001) do |ws|
						p ws
						ws.onopen{
							puts 'Connection open'
							@@socket_state = :on
							puts @@socket_state.to_s
							ws.send "Hello!"
						}

						ws.onclose{
							puts "Connection closed"
							@@socket_state = :off
						}

						ws.onmessage{ |msg|
							@user = User.find(1)
							puts "Recieved message: #{msg}"
							ws.send "Pong: #{@@socket_state}"
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