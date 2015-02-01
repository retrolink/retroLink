opera.extension.addEventListener('message', function(event) {
	if (event.data == window.location){
		var url = window.location;
		window.location = 'http://retrolink.com.br/api/?versao=1&addon=opera&url=' + url;
	}
}, false);