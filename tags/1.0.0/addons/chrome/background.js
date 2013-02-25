chrome.browserAction.onClicked.addListener(
	function (tab) {
		chrome.tabs.create({
			'url': 'http://retrolink.com.br/api/?addon=chrome&url=' + tab.url,
			'selected': true
		});
	}
);