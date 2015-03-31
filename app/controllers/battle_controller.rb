class BattleController < ApplicationController

	def pls_start
		EventMachine.run{
			EventMachine::WebSocket.start(:host => 'localhost', :port => 9001) do |ws|
				ws.onopen{
					puts 'Connection open'

					ws.send "Hello!"
				}

				ws.onclose{
					puts "Connection closed"
				}

				ws.onmessage{ |msg|
					puts "Recieved message: #{msg}"
					ws.send "Pong: #{msg}"
				}
				render 'battle/battle'
		end
		}
	end

end
