chrome.browserAction.onClicked.addListener(
	function (tab) {
		chrome.tabs.update(tab.id, {url: 'http://retrolink.com.br/api/?addon=firefox&url=' + tab.url});
	}
);