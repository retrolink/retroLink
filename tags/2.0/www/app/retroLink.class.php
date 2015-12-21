<?php

require(APP.'lib/http.class.php');
require(APP.'lib/strings.class.php');

final class retroLink {
	
	private $_finalResult  = '';
	private $_originalLink = '';
	
	private $_errorCode = 0;
	private $_success   = 0;
	
	public function __construct($link) {
		
		$this->_originalLink = $link;
		
		$link = $this->processShortner($link);
		
		if ($this->baseCheck($link)) {
			
			$link = $this->process($link);
			$link = $this->processShortner($link);
			
			$this->baseCheck($link, true);
			
		}
		
		if (!$this->_errorCode && $this->_originalLink == $link) $this->setError(6);
		
		$this->logResult($link);
		
		$this->_finalResult = array('success' => $this->_success, 'error' => $this->_errorCode, 'url' => $link);
		
	}
	
	private function baseCheck($link, $final = false) {
		
		if ($this->_errorCode) return false;
		
		if ($this->checkList($link, 1)) {
			
			if (!$final) return $this->setError(1);
			else {
				
				$this->success();
				return false;
				
			}
			
		}
		
		if ($this->checkList($link, 2)) return $this->setError(2);
		if ($this->checkList($link, 4)) return $this->setError(4);
		if ($this->checkList($link, 5)) return $this->setError(5);
		if ($this->checkList($link, 3)) return $this->setError(3);
		
		return true;
		
	}
	
	private function process($link) {
		
		include(APP.'Factory.class.php');
		
		$host = Factory::getHost($this->getHost($link), $link);
		
		//if ($link == $host->_link && get_class($host) != 'GenericHost') $host = new GenericHost($link);
		
		if (method_exists($host, 'getResult')) return $host->getResult();
		else $this->logResult('Undefined method. '.$host.' '.$link);
		
		return $link;
		
	}
	
	private function processShortner($link) {
		
		if (!$this->checkList($link)) return $link;
		
		$page = http::getPage($link);
		
		if (stripos($page, 'ocation: ') === false) return $link;
		
		return strings::cut_str($page, 'ocation: ', "\r");
		
	}
	
	// 0 - shortner, 1 - unprotected, 2 - notRelated, 3 - untrusted, 4 - oldServers
	private function checkList($link, $list = 0) {
		
		if ($this->_errorCode) return false;
		
		switch($list) {
			
			case 1:
				$list = 'serversUrls';
			break;
			
			case 2:
				$list = 'notRelatedUrls';
			break;
			
			case 3: 
				$list = 'untrustedUrls';
			break;
			
			case 4:
				$list = 'oldServers';
			break;
			
			case 5:
				$list = 'urlsWithCaptcha';
			break;
			
			case 0:
			default:
				$list = 'urlShorteners';
			break;
			
		}
		
		include(APP.'inc/'.$list.'.inc.php');
		
		if (is_array($list) && in_array($this->getHost($link), $list)) return true;
		
		return false;
		
	}
	
	private function success() {
		
		$this->_success = 1;
		
		return true;
		
	}
	
	private function setError($code) {
		
		$this->_errorCode = $code;
		
		return false;
		
	}
	
	private function getHost($link) {
		
		$host = parse_url($link, PHP_URL_HOST);
		
		$z = explode('.', $host, 3);
		if ($z[1] == 'zippyshare') return $z[1];
		
		return str_ireplace('www.', '', $host);
		
	}
	
	// 0 = array, 1 = query, 2 = json
	public function getResult($type = 0) {
		
		switch($type) {
			
			case 1:
				return http_build_query($this->_finalResult);
			break;
			
			case 2:
				return json_encode($this->_finalResult);
			break;
			
			case 0:
			default:
				return $this->_finalResult;
			break;
			
		}
		
	}
	
	private function logResult($link, $shortner = false) {
		
		$log = date("H:i:s").': '.$this->_success.':'.$this->_errorCode.' -> '.$this->_originalLink.' => '.$link."\r\n";
		
		file_put_contents(APP.'logs/'.date("d-m-Y").'.log', $log, FILE_APPEND|LOCK_EX);
		
	}
	
}

?>