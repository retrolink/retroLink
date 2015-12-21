<?php

if (!empty($_GET['url'])) $_POST['url'] = $_GET['url'];

if (empty($_POST['url'])) {
	
	if (!empty($_GET['type'])) echo 'null';
	else echo "
		<script type=\"text/javascript\">
			window.location = 'http://retrolink.com.br';
		</script>
	";
	
	exit();
	
} else {
	
	if (stripos($_POST['url'], 'http') === false) $_POST['url'] = 'http://'.$_POST['url'];
	
	if (filter_var($_POST['url'], FILTER_VALIDATE_URL) === false) {
		
		if (!empty($_GET['type'])) echo 'null';
		else echo "
			<script type=\"text/javascript\">
				Growl('Ocorreu um erro', 'É necessário utilizar uma url válida, por favor tente novamente...', 'ff0000', false);
			</script>
		";
		
		exit();
		
	}
	
}

define(APP, '../app/');
require(APP.'retroLink.class.php');

$retroLink = new retroLink(strip_tags($_POST['url']));
$result = $retroLink->getResult();

if (!empty($_GET['type'])) {
	
	if ($_GET['type'] == 'query') echo $retroLink->getResult(1);
	elseif ($_GET['type'] == 'json') echo $retroLink->getResult(2);
	elseif ($_GET['type'] == 'text') echo $result['url'];
	
	exit();

}

$host   = parse_url($_POST['url'], PHP_URL_HOST);
$link   = substr($result['url'], 0, 65);
$link_o = substr($_POST['url'], 0, 65);

if (strlen($result['url']) > 65) $link  .= '...';
if (strlen($_POST['url']) > 65) $link_o .= '...';

if ($_GET['addon']) {
	
	echo '<html></head><meta http-equiv="Content-type" content="text/html; charset=UTF-8" /></head><body>';
	
	echo "
		<script type=\"text/javascript\">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-34397595-1']);
		  _gaq.push(['_trackPageview']);
		
		  (function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		</script>
	";
	
}

if (!empty($result['url']) && ($result['success'] || !$result['error'])) {	
	
	if ($_GET['addon']) {
		
		echo "
			<script type=\"text/javascript\">
				window.location = '".$result['url']."';
			</script>
		";
		
		exit();
		
	} else {
		
		echo "
			<font size=\"4\">Link desprotegido com sucesso!</font>
			<br /><br />
			<img src=\"/static/img/valid.png\" class=\"valid\">
			<span>
				<a rel=\"nofollow\" href=\"".$result['url']."\" class=\"urldownload\" title=\"".$result['url']."\" target=\"_blank\">".$link."</a>
			</span>
			<script type=\"text/javascript\">
				Growl('Sucesso!', 'Sua url foi desprotegida com sucesso! Agradeça divulgando nosso serviço!', '00FF00', false);
			</script>
			<div id=\"url\" style=\"display:none\">".$result['url']."</div>
		";
	}
	
} else {
	
	if ($result['error'] == 1) {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('Esse link já é de um servidor oficial. Não é necessário desproteger :)');
					window.location = '".$_POST['url']."';
				</script>
			";
			
		} else {
			
			echo "
				<img src=\"/static/img/valid.png\" class=\"valid\">Esse link já é de um servidor oficial,
				<a href=\"javascript:alerta_colorbox('box_desprotegido');\" class=\"errodownload\">clique aqui</a> para mais informações
				<br /><br />
				<img src=\"/static/img/arquivo_online.png\" class=\"valid\">
				<span>
					<a rel=\"nofollow\" href=\"".$result['url']."\" class=\"urldownload\" title=\"".$result['url']."\" target=\"_blank\">".$link."</a>
				</span>
				<div id=\"url\" style=\"display:none\">".$result['url']."</div>
			";
			
		}
		
	} elseif ($result['error'] == 2) {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('\'".$_POST['url']."\' não é uma url protegida.');
					window.location = 'http://retrolink.com.br';
				</script>
			";
			
		} else {
			
			echo "
				<strong>'".$_POST['url']."'</strong> não é uma url protegida,
				<a href=\"javascript:alerta_colorbox('box_desprotegidao');\" class=\"errodownload\">clique aqui</a> para mais informações
				<script type=\"text/javascript\">
					Growl('Ocorreu um erro', 'Essa não é uma url protegida.', 'ff0000', false);
				</script>
			";
			
		}
		
	} elseif ($result['error'] == 3) {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('Consta em nosso sistema que o site ".$host.", é fraudulento pois exibe apenas propaganda... portanto, nada feito :/');
					window.location = 'http://retrolink.com.br';
				</script>
			";
			
		} else {
			
			echo "
				Consta em nosso sistema que o site <strong>".$host."</strong>, é fraudulento,
				<a href=\"javascript:alerta_colorbox('box_fraudulento');\" class=\"errodownload\">clique aqui</a> para mais informações
				<script type=\"text/javascript\">
					Growl('Ocorreu um erro', 'Site fraudulento detectado!', 'ff0000', false);
				</script>
			";
			
		}
		
	} elseif ($result['error'] == 4) {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('O link foi desprotegido, mas ele corresponde a um servidor que não existe mais :/');
					window.location = '".$result['url']."';
				</script>
			";
			
		} else {
			
			echo "
				<img src=\"/static/img/invalid.png\" class=\"valid\">
				O link foi desprotegido, mas ele é de um servidor que não existe mais.
				<a href=\"javascript:alerta_colorbox('box_antigo_servidor');\" class=\"errodownload\">Clique aqui</a> para mais informações
				<br /><br />
				<img src=\"/static/img/arquivo_offline.png\" class=\"valid\">
				<span>
					<a rel=\"nofollow\" href=\"".$result['url']."\" class=\"urldownload\" title=\"".$result['url']."\" target=\"_blank\">".$link."</a>
				</span>
				<div id=\"url\" style=\"display:none\">".$result['url']."</div>
			";
			
		}
		
	} elseif ($result['error'] == 5) {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('Esse protetor usa captcha. Resolva o captcha para desproteger.');
					window.location = '".$_POST['url']."';
				</script>
			";
			
		} else {
			
			echo "
				<img src=\"/static/img/invalid.png\" class=\"valid\">
				Esse protetor usa captcha. Acesse o link e resolva o captcha para desproteger.
				<br /><br />
				<img src=\"/static/img/ico_parceiro.png\" class=\"valid\">
				<span>
					<a rel=\"nofollow\" href=\"".$_POST['url']."\" class=\"urldownload\" title=\"".$_POST['url']."\" target=\"_blank\">".$link_o."</a>
				</span>
			";
			
		}
		
	} else {
		
		if ($_GET['addon']) {
			
			echo "
				<script type=\"text/javascript\">
					alert('Esta url não é suportada... para maiores informações veja a lista de sites suportados pelo sistema, na página do addon.');
					window.location = 'http://retrolink.com.br';
				</script>
			";
			
		} else {
			
			echo "
				<img src=\"/static/img/invalid.png\" class=\"valid\">
				Não foi possível desproteger esta url, <a href=\"javascript:alerta_colorbox('box_info');\" class=\"errodownload\">clique aqui</a> e saiba as possíveis causas para isso.
				<br /><br />
				<img src=\"/static/img/movies.png\" class=\"valid\">
				Caso ainda esteja com dúvidas, <a href=\"javascript:alerta_colorbox('box_video_youtube');\" class=\"errodownload\"><strong>clique aqui</strong></a> e saiba como utilizar o sistema.
			";
			
		}
		
	}
	
}

if ($_GET['addon']) echo '</body></html>';

?>