<?php
function get_url($url) {

	$ch = curl_init ($url);

	curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
	curl_exec ($ch);

	if (!curl_errno ($ch))
	
	$url = curl_getinfo ($ch, CURLINFO_EFFECTIVE_URL);
	curl_close ($ch);
	
	return $url;
 
}

$url = $_GET['url'];
$longurl = get_url($url);
echo $longurl;
?>