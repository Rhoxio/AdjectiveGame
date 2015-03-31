SOCKET_URI = 'ws://127.0.0.1:9001'

$(document).ready(function(){

console.log("Loaded BattleUI...")

var ws = new WebSocket(SOCKET_URI)

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

})

// Nothing in here yet. This will be the file that
// contains most of the view and rendering logic. 

