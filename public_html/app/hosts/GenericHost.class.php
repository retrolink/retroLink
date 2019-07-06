<?php

function cmp($a, $b) { return strcmp($a, $b); }

class GenericHost {
	
	private $_result    = '';
	private $_patterns  = array();
	private $_minLength = 15;
	private $_break     = false;
	
	protected function init() {
		
		$this->_patterns = array(
			
			array('base64'),
			array('hex'),
			array('base64', 'hex'),
			array('hex', 'base64'),
			array('base64', 'base64'),
			array('hex', 'hex'),
			array('base64', 'base64', 'base64'),
			
		);
		
	}
	
	public function __construct($link) {
		
		$this->init();
		
		$link_s = substr($link, 1);
		if (!stripos($link_s, 'http://') && !stripos($link_s, 'https://')) $link = str_ireplace(':=', ':=http://', $link);
		
		$normalSegments  = self::getSegments($link);
		$specialSegments = self::getSpecialSegments($link);
		
		$path = explode('/', $normalSegments['path']);
		parse_str($normalSegments['query'], $query);
		
		$this->searchLink(array_merge($query, $specialSegments, $path), $normalSegments['fragment']);
		
		if (empty($this->_result)) $this->extractHttp($link_s);
		
		if (empty($this->_result)) $this->_result = $link;
		
	}
	
	protected function searchLink($array, $string) {
		
		$array = array_filter($array);
		usort($array, 'cmp');
		
		foreach ($array as $var => $value) $this->seekLink($value);
		
		$this->seekLink($string);
		
	}
	
	protected function seekLink($string) {
		
		$this->extractHttp($string);
		$this->extractHttp(urldecode($string));
		
		foreach ($this->_patterns as $pattern) {
			
			if ($this->_break) break;
			
			$temp = $string;
			
			foreach ($pattern as $var => $value) {
				
				if ($value == 'base64') $temp = base64_decode($temp);
				elseif ($value == 'hex') $temp = preg_replace("'([\S,\d]{2})'e", "chr(hexdec('\\1'))", $temp);
				
			}
			
			$this->extractHttp($temp);
			
		}
		
	}
	
	protected function extractHttp($segment) {
		
		if ($this->_break) return false;
		
		if (stripos($segment, 'magnet:') === 0) $this->setLink($segment);
		elseif (preg_match('/(htt.*)/', $segment, $l)) $this->setLink($l[1]);
		elseif (preg_match('/(htt.*)/', strrev($segment), $l)) $this->setLink($l[1]);
		
	}
	
	protected static function isLink($link) {
		
		if (stripos($link, 'magnet:') === 0 || preg_match('/(htt.*)/', $link, $l)) return true;
		
		return false;
		
	}
	
	protected function setLink($link) {
		
		if (strlen($link) >= $this->_minLength) {
			
			//$this->_results[] = $link;
			$this->_result = $link;
			
			$this->_break = true;
			
		}
		
	}
	
	protected static function getSpecialSegments($string) {
		
		$markers = array('!', '?', ':=');
		$result  = array();
		
		foreach ($markers as $var => $value) {
			
			if (stripos($string, $value) !== false) {
				
				$tmp = explode($value, $string, 2);
				if (!empty($tmp[1])) $result[] = $tmp[1];
				
			}
			
		}
		
		return $result;
		
	}
	
	protected static function getSegments($link) {
		
		$link = parse_url($link);
		
		return array('path' => $link['path'], 'query' => $link['query'], 'fragment' => $link['fragment']);
		
	}
	
	public function getResult() {
		
		return $this->_result;
		
	}
	
}

?>