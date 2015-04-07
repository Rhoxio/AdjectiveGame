SOCKET_URI = 'ws://localhost:9001'

$(document).ready(function(){

console.log("Loaded BattleUI...")

ws = new WebSocket(SOCKET_URI)

ws.onopen = function(){
	console.log(ws)
	// ws.send('Socket is Open!')
}

ws.onmessage = function(msg){
	character = $.parseJSON(msg.data)
	$('.text-display').html(character.name)
}

ws.onclose = function(){
	console.log("Socket closed")
}


$('.test-button').on('click', function(){

	ws.send('{"hello": "goodbye"}')
})



})

