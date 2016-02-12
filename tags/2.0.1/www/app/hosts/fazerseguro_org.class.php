<?php 

# http://www.fazerseguro.org/link/?id=6d61676e65743a3f78743d75726e3a627469683a3544374537323442334230373036453646453745333836453434333946314531424341434638423726646e3d4249332e42445269702e4455414c2d526567756569726f2e7261722674723d756470253361253266253266747261636b65722e6f70656e626974746f7272656e742e636f6d2533613830253266616e6e6f756e63652674723d756470253361253266253266747261636b65722e7075626c696362742e636f6d2533613830253266616e6e6f756e6365

class fazerseguro_org extends GenericHost implements Hosts {
	
	public function __construct($link) {
		
		parent::__construct($this->processLink($link));
		
	}
	
	private function processLink($link) {
		
		$page = http::getPage($link);
		
		$redirect = trim(strings::cut_str($page, '<a target="_blank" href="', '"'));
		
		if (stripos($redirect, 'http') === false) return $link;
		
		return $redirect;
		
	}

}

?>