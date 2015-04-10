SOCKET_URI = 'ws://localhost:9001'

function character(name, id){
 this.name = name
 this.id = id
}

function reqObject(action, target, assailant, attack){
	this.action = action
	this.target = target
	this.assailant = assailant
	this.attack = attack
}

$(document).ready(function(){

view = new View

bob = new character("Bob", 1)
mandy = new character("Mandy", 2)
jim = new character("Jim", 3)
rick = new character("Rick", 4)

view.loadCharacters([bob, mandy, jim, rick])

// view.loadCharacters()

console.log("Loaded BattleUI...")

ws = new WebSocket(SOCKET_URI)

ws.onopen = function(){
	console.log(ws)
	// Grab character data and render it with View.loadCharacters.
}

ws.onmessage = function(msg){
	// I need to set a condition to sort functionality. 
	response = $.parseJSON(msg.data)
	$('.text-display').html(response.name)
}

ws.onclose = function(){
	console.log("Socket closed")
}


$('.test-button').on('click', function(){
	request = new reqObject('attack', 1, 2, 3)
	ws.send(JSON.stringify(request))
})



})

