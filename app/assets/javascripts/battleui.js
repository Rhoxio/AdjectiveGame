SOCKET_URI = 'ws://localhost:9001'

$(document).ready(function(){

console.log("Loaded BattleUI...")

ws = new WebSocket(SOCKET_URI)

ws.onopen = function(){
	console.log("Socket open")
	ws.send('Initial Message from Socket')
}

ws.onmessage = function(msg){
	console.log(msg.data)
	$('.text-display').html(msg.data)
}

ws.onclose = function(){
	console.log("Socket closed")
}


$('.test-button').on('click', function(){
	$('.text-display').html("Text to be appended")
	ws.send("Button Clicked")
})

})

