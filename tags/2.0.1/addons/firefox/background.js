chrome.browserAction.onClicked.addListener(
	function (tab) {
		chrome.tabs.create({
			'url': 'http://retrolink.com.br/api/?addon=firefox&url=' + tab.url,
			'selected': true
		});
	}
);