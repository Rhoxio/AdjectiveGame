SOCKET_URI = 'ws://localhost:9001'
CHARACTER_SET = []
BOSS = null

CURRENT_TARGET = null

function reqObject(action, target, assailant, attack){
	 // Could just feed IDs in to this. The DB will have to figure it all out, anyway. 
	this.action = action
	this.target = target
	this.assailant = assailant
	this.attack = attack
}

$(document).ready(function(){

console.log("Loaded BattleUI...")

view = new View

ws = new WebSocket(SOCKET_URI)

ws.onopen = function(msg){
	console.log(ws)
	console.log(msg)
}

ws.onmessage = function(msg){
	response = $.parseJSON(msg.data)

	if (response.action == 'load'){
		// For some reason, the parser didn't recognize that there was another
		// object that needed to be converted over to an object. In this case,
		// it was the boss object. Wierd. It may have to do with jQuery
		// checking arrays for parsing automatically or something. 
		CHARACTER_SET = response.characters
		BOSS = $.parseJSON(response.boss)

		view.displayText('Characters Loaded!!')
		view.loadCharacters(CHARACTER_SET)
		view.loadBoss(BOSS)
	}

	
}

ws.onclose = function(){
	console.log("Socket closed")
}


$('.test-button').on('click', function(){
	request = new reqObject('attack', 1, 2, 3)
	ws.send(JSON.stringify(request))
})



})

