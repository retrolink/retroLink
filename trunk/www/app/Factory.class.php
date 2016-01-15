<?php

include(APP.'Hosts.interface.php');

function __autoload($class) {
	
	if (file_exists(APP.'./hosts/'.$class.'.class.php')) {
		
		include_once(APP.'./hosts/'.$class.'.class.php');
		
	}
	
	return class_exists($class, false);
	
}

final class Factory {
	
    public static function getHost($host, $link) {
		
		$host = str_ireplace('.', '_', $host);
		
		if (class_exists($host)) return new $host($link);
		else return new GenericHost($link);
		
    }
	
}

?>
