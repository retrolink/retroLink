window.addEventListener('DOMContentLoaded', function() {
	
	var button;
    var tab;

	var UIItemProperties = {
		disabled: false,
		title: 'Desproteger URL',
		icon: 'images/icon.png',
		onclick: function() {
			tab = opera.extension.tabs.getFocused();
			if (tab) {
                opera.extension.broadcastMessage(encodeURI(tab.url));
			}
		}
	};

    button = opera.contexts.toolbar.createItem( UIItemProperties );
    opera.contexts.toolbar.addItem(button);
    
	function toggleButton() {
		var tab = opera.extension.tabs.getFocused();
		if (tab) {
			button.disabled = false;
		} else {
			button.disabled = true;
		}
	}

	opera.extension.onconnect = toggleButton;
	opera.extension.tabs.onfocus = toggleButton;
	opera.extension.tabs.onblur = toggleButton;

}, false);