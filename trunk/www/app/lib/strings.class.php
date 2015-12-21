<?php

class strings {
	
	public static function cut_str($str, $left, $right) {
		
		$str = substr(stristr($str, $left), strlen($left));
		$leftLen = strlen(stristr($str, $right));
		$leftLen = $leftLen ? - ($leftLen) : strlen($str);
		
		return substr($str, 0, $leftLen);
		
	}
	
}

?>