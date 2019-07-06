<?php 

# http://linkei.top/VUmXl

class linkei_top extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		parent::__construct($this->processLink($link));
		
	}
	
	private function processLink($link) {
		
		$page = http::getPage($link);
		
		$newLink = '<a href="http://linkei.top/?r='.trim(strings::cut_str($page, '<a href="http://linkei.top/?r=', '"'));
		
		if (empty($newLink)) return $link;
		
		return parent::__construct($newLink);
		
	}

}

?>