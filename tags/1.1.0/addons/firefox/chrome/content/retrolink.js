var RetroLink_app = {
	
	/*	
	 * This button must be always on toolbar because the addon is only this button.
	 * If the user doesn't want it anymore he should uninstall the addon.
	*/
	addButton: function() {
		
		var navbar = document.getElementById("nav-bar");
		
		if (navbar.currentSet.search("retrolink-toolbar-button") < 0) {
			
			var newset = navbar.currentSet + ",retrolink-toolbar-button";
			navbar.currentSet = newset;
			navbar.setAttribute("currentset", newset);
			document.persist("nav-bar", "currentset");
			
		}
		
	}

};

window.addEventListener("load", RetroLink_app.addButton(), false);