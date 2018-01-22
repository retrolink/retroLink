<?php

function testUserIP($user_ip, $cidrs) {
	
	$ipu = explode('.', $user_ip);
	
	foreach ($ipu as &$v) $v = str_pad(decbin($v), 8, '0', STR_PAD_LEFT);
	
	$ipu = join('', $ipu);
	$res = false;
	
	foreach ($cidrs as $cidr) {
	
		$parts = explode('/', $cidr);
		$ipc = explode('.', $parts[0]);
		
		foreach ($ipc as &$v) $v = str_pad(decbin($v), 8, '0', STR_PAD_LEFT);
		
		$ipc = substr(join('', $ipc), 0, $parts[1]);
		$ipux = substr($ipu, 0, $parts[1]);
		$res = ($ipc === $ipux);
		
		if ($res) break;
		
	}
	
	return $res;
	
}

include('./inc/allowed_cidrs.php');

if (empty($allowed_cidrs) || !testUserIP($_SERVER['REMOTE_ADDR'], $allowed_cidrs)) exit();

?>
<html>
<head>
	<meta http-equiv="refresh" content="3600">
</head>
<body>

</body>
</html>