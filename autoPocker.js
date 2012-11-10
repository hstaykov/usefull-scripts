var autoPoke = function() {
	var pokeClass = 'uiIconText';
	var pokes = document.getElementsByClassName(pokeClass);

	for(var i = 0; i<pokes.length; ++i){
	    	var poke = pokes[i];
		if ('Poke back' == poke.childNodes[1].data){
			console.log('You have just poked someone :)');
		    	poke.click();
		}
	}
}

setInterval(autoPoke, 3000);
