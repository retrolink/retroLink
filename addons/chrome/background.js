chrome.action.onClicked.addListener((tab => {
	chrome.tabs.create({
		'url': 'https://retrolink.com.br/api/?addon=chrome&url=' + tab.url,
		'selected': true
	});
}));