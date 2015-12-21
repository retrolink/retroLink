<?php 

# http://lix.in/-d339bc

class lix extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		if ($this->checkLink($link)) $link = $this->processLink($link);
		
		parent::__construct($link);
		
	}
	
	private function checkLink($link) {
		
		return preg_match('/^https?:\/\/lix\.in/i', $link);
		
	}
	
	private function processLink($link) {
		
		preg_match('/^https?:\/\/lix\.in\/(.*)/i', $link, $tiny);
		
		$page = http::getPage($link, array('tiny' => $tiny[1], 'submit' => 'continue'));
		
		$redirect = trim(strings::cut_str($page, 'ifram" src="', '"'));
		
		if (stripos($redirect, 'http') === false) return $link;
		
		return $redirect;
		
	}

}

?>