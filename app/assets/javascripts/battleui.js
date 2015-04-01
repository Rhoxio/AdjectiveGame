SOCKET_URI = 'ws://localhost:9001'

$(document).ready(function(){

console.log("Loaded BattleUI...")

ws = new WebSocket(SOCKET_URI)

ws.onopen = function(){
	console.log("Socket open")
	ws.send('Message')
}

ws.onmessage = function(msg){
	console.log(msg)

}

ws.onclose = function(){
	console.log("Socket closed")
}

var changeText = function(element, socket, text){
	if (socket.readyState != 0){
			socket.send(text)
			$(element).html(text)
	}
	else if (socket.readyState == 0) {
		console.log('The socket isnt open.')
	}
}

$('.test-button').on('click', function(){
	console.log('hitting the button.')
	changeText('.text-display', ws, "New text!");
})

})

