<?php 

# http://protetor.therevolution.com.br/curtir/1548

class protetor_therevolution_com_br extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		parent::__construct($this->processLink($link));
		
	}
	
	private function processLink($link) {
		
		$page = http::getPage($link);
		
		$redirect = trim(strings::cut_str($page, '<a href=\'', '\''));
		
		if (stripos($redirect, 'http') === false) return $link;
		
		return $redirect;
		
	}

}

?>