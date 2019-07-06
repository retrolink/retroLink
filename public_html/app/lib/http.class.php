<?php

class http {
	
	private static $_bindIP = false;
	
	public static function getPage($link, $post = false, $cookies = '', $timeout = 5) {
		
		$timeout_t = $timeout * 2;
		
		$options = array (
			
			CURLOPT_URL               => $link,
			CURLOPT_HEADER            => true,
			CURLOPT_RETURNTRANSFER    => true,
			CURLOPT_FORBID_REUSE      => false,
			CURLOPT_FRESH_CONNECT     => false,
			//CURLOPT_CLOSEPOLICY       => 'CURLCLOSEPOLICY_OLDEST',
			CURLOPT_DNS_CACHE_TIMEOUT => 1800,
			CURLOPT_CONNECTTIMEOUT    => $timeout,
			CURLOPT_TIMEOUT           => $timeout_t,
			CURLOPT_USERAGENT         => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20100101 Firefox/14.0.1',
			CURLOPT_HTTPHEADER        => array('Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
			
		);
		
		if (self::$_bindIP) $options[CURLOPT_INTERFACE] = self::$_bindIP;
		if (!empty($cookies)) $options[CURLOPT_COOKIE] = $cookies;
		
		if (is_array($post)) {
			
			$options[CURLOPT_POST]       = true;
			$options[CURLOPT_POSTFIELDS] = http_build_query($post);
			
		}
		
		$ch = curl_init();
		curl_setopt_array($ch, $options);
		
		$response = curl_exec($ch);
		
		curl_close($ch);
		
		return $response;
		
	}
	
}

?>