<?php 

# http://www.comicon.com.br/prot.php?oq3dGcVk8R0pi8pvjWw4E/20SHy2wqxTStxcF9ferarwdvOTFlzAeHSIvlA3P6fbm9ryqsxHI3xq8Pvc4PRN9o9wOItv

class comicon_com_br extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		parent::__construct($this->processLink($link));
		
	}
	
	private function processLink($link) {
		
		$page = http::getPage($link);
		
		$redirect = trim(strings::cut_str($page, 'FF0000;" href="', '"'));
		
		if (stripos($redirect, 'http') === false) return $link;
		
		return $redirect;
		
	}

}

?>