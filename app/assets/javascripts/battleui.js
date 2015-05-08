// A Note About Event Delegation:
// You should be able to just load the attacks for a specific character and assign those to
// one of the four attack options. You really don't even have to use event delegation if
// you simply keep the formatting as consistent as humanly possible.

// It will end up being much like the view.loadCharacters function.

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
		// object in the hash that needed to be converted over to an object. In this case,
		// it was the boss object. Wierd. It may have to do with jQuery
		// checking arrays for parsing automatically or something.

		// EDIT: Nope. It was ActiveRecord not serializing the hash correctly. I will
		// just have to live with this workaround for the moment. 
		
		CHARACTER_SET = response.characters
		BOSS = $.parseJSON(response.boss)
		console.log(CHARACTER_SET[0])

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

