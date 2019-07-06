<?php 

# http://linkurl.xyz/RKUOo

class linkurl_xyz extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		parent::__construct($this->processLink($link));
		
	}
	
	private function processLink($link) {
		
		$page = http::getPage($link);
		
		$redirect = trim(strings::cut_str($page, 'window.location="', '"'));
		
		if (!parent::isLink($link)) return $link;
		
		return $redirect;
		
	}

}

?>