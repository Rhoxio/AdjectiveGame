numConvert = {} 

numConvert[1] = 'one'
numConvert[2] = 'two'
numConvert[3] = 'three'
numConvert[4] = 'four'
numConvert[5] = 'five'
numConvert[6] = 'six'
numConvert[7] = 'seven'
numConvert[8] = 'eight'
numConvert[9] = 'nine'

var View = function(){
	console.log('View loaded...')
}

View.prototype.updateTarget = function(object){
// This is going to have to loate the DOM elemtnts associated with the object
// and ammend all of the values based on the data in that object.
$('#everyfuckingelemenetid'+object.id).html('New stuff!')
}

View.prototype.loadCharacters = function(characters){

	$.each(characters, function(index, character){
		currentElement = '.p' + numConvert[index + 1]
		console.log(currentElement)
		$(currentElement).html(character.name)
		$(currentElement).attr('id', ""+character.id)
	})
	// I am assuming an array will be passed in here. If I use a hash, I will have to change this.

	// I also need to assign ids based upon their own ids. That means I am going to have to add
	// an ID field to the elements using javascript/jquery. I think this
	// is clean, but I will have to test it out to see how it behaves.

}

View.prototype.loadBoss = function(boss){
	// Takes a single boss object and reders it's inital state. Should only need to be rendered once per page-load.
	$('.boss-info').html(boss.name)
}

View.prototype.textCycle = function(responseObject){
	// This method will render to the text display area. I am planning on putting it on
	// a one to three second timer depending on how long the text itself is.
	$('.text-display').html(responseObject.text)
}

View.prototype.displayItems = function(items){
	// This function is going to be linked to items associated with the current session ID
	// of the person playing. I am not usre how I am going to implement a balanced
	// item system in a multiplayer game (probably some limit on how many can be used per fight),
	// but I can worry about that once I atually get the logic written for it.

	// Also, you need to save individual states to make it toggle. Design decisions... 
	$('.inventory-display').css('visibility', 'visible')

}

View.prototype.displayAttacks = function(attacks){
	// The attack objects should get sent along with the initial request from the server.
	// I should be able to essentially look at them and display their info in a new panel when the
	// 'Attack' button is clicked. 

	// I don't know if I should render these divs first and simply use the visibility property
	// to display them, or have them render new data every time the element is clicked.
	// It would be using a version of the objects that was retrieved at the beginning of the
	// fight, but if there is no reason to get a new version, then this will work fine. 
}

View.prototype.discoverAttribute = function(target, attribute){
	// This game is going to be about acquiring information, so discovering things
	// about your opponent is extremely important. This will have to update the DOM depending on which attributes
	// need to be uncovered. It may be the bosses moveset, or the character's items. 
	// Something to that effect...
}



