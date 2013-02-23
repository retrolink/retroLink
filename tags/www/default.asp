<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="pt-br" dir="ltr" xml:lang="pt-br" xmlns="http://www.w3.org/1999/xhtml">
	<head profile="http://gmpg.org/xfn/11">
		<title>retroLink.com.br | Desprotetor de links, burlar links protegidos, desproteger links de download</title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="content-style-type" content="text/css" />
		<meta name="keywords" content="downloads, link protection, proteção links, deproteger, desproteger link, download direto, link protegido, reverse link, reveter link, retro link," />
		<meta name="description" content="Faça seus downloads eliminando as páginas protetoras de link. Instale agora o Desprotetor de Links em seu navegador e com aspenas um clique burle estes links protegidos" />
		<link media="screen" type="text/css" rel="stylesheet" href="/static/css/style.css" />
		<link rel="icon" href="favicon.ico" />
		<link rel="shortcut icon" href="favicon.ico" />
		<link rel="canonical" href="http://retrolink.com.br/" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		<script type="text/javascript" src="/static/javascript/jquery.gritter.min.js"></script>
		<script src="/static/javascript/jquery.colorbox.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){

			$("#redes-sociais").fadeIn(800);

			$(window).scroll(function(){
				if ($(this).scrollTop() != 0){
					$('#irtopo').stop().animate({"right": 0});
				} else {
					$('#irtopo').stop().animate({"right": "-38px"});
				}
			});

			$('#irtopo').click(function(){
				$('body,html').animate({scrollTop:0},900);
			});

			$("#formbusca").submit(function() {

				$("#verificar").removeClass("sucesso");
				$("#verificar").removeClass("erro");

				var links = $("#campourl").val();

				if (links == 'http://') {
					$("#verificar").addClass("sucesso");
					Growl('Ocorreu um erro', 'É necessário utilizar uma url válida, por favor tente novamente...', 'ff0000', false);
					return false;
				} else if (links == ''){
					$("#verificar").addClass("sucesso");
					Growl('Ocorreu um erro', 'É necessário especificar a url que deseja desproteger, por favor tente novamente...', 'ff0000', false);
					return false;
				} else if (links !== '') {

					$("#verificar").addClass("aguarde");
					$("#verificar").html("Aguarde...");
					$('#verificar').attr("disabled", true);

					$('#campourl').attr("disabled", true);

					$('#resultado').fadeIn(800).html("<img src='/static/img/loading.gif' style='float: left; padding-right:4px'>Aguarde, estamos verificando seu link...")
					$.post("/api/",{links:links},
					function(data){
						$('#resultado').html(data);
						$("#verificar").addClass("sucesso");
						$("#verificar").html("Desproteger");
						$("#limpar").fadeIn(800);
						$('#campourl').removeAttr("disabled");
						$('#verificar').removeAttr("disabled");
						contador();
					});
					return false;
				}

			});

			$("#limpar").click(function() {
				$("#campourl").val('http://');
				$('#resultado').fadeOut();
				$('#limpar').fadeOut(800);
				$.gritter.removeAll();
				return false;
			});

			//counter de links verificados
			function contador(){
				$.post('/inc/counter.asp', function(data) {
					var contador = $("#contador").text();
					if (contador < data){
						$('#contador').fadeOut(800);
						$('#contador').fadeIn(800).text(data);
					}
				});
			}

			//executa a contagem do count de 10 em 10 segundos
			setInterval(contador,10000);

		});

		//function gritter
		function Growl(n_title, n_msg, color, fixed) {
			color = color || "aefd8e";
			fixed = fixed || false;
			$.gritter.add({
				title: '<span style="color: #' + color + '">' + n_title + '</span>',
				text: n_msg,
				sticky: fixed
			});
		}

		//ESSE AINDA NÃO TESTEI...
		function alerta_colorbox(u,t,w,h) {

			var url    = u; //u = url
			var tipo   = t; //t = tipo
			var width  = w; //w = width
			var height = h; //h = height

			if (tipo == 1) {
				//$.fn.colorbox({href:"/inc/box/box_fraudulento.asp", width:"50%"});
				$.fn.colorbox({href:"/inc/box/"+url+".asp", width:"50%"});
			} else if (tipo == 2){
				//$.fn.colorbox({width:"50%", inline:true, href:"#inline"});
				$.fn.colorbox({width:"50%", inline:true, href:"#"+url});
			} else if (tipo == 3){
				//$.fn.colorbox({href:"/verificar-link/estilo.asp", innerWidth:640, innerHeight:340});
				$.fn.colorbox({href:"/inc/box/"+url+".asp", innerWidth:width, innerHeight:height});
			}

		}
		
		function alerta() {
			$.fn.colorbox({width:"50%", inline:true, href:"#inline"});
		}

		function fraudulento() {
			$.fn.colorbox({href:"/inc/box/box_fraudulento.asp", width:"50%"});
		}

		function linkquebrado() {
			$.fn.colorbox({href:"/inc/box/box_linkquebrado.asp", width:"50%"});
		}

		function verifica_link(link) {
			$.post("/inc/verifica/",{link:link},
				function(data){
					$('#verifica_arquivo').html(data);
				}
			);
		}

		function link_quebrado(acao) {
			if (acao == "offline") {
				$("#resultado a").addClass("urldownloadquebrado");
			}
		}
		</script>
		
	</head>
	<body>
	<!-- menu
	<style>
		div.menu_item { text-align: center; float: left; background-color: #463906; padding: 5px 15px 7px 15px; margin-right: 2px;}
		div.menu_item a { color: #fff; font: 15px Helvetica, Arial, Sans-Serif; }
	</style>
	<div id="menu" style="position: absolute; z-index: 99; left: 50%;">
		<div style="width: 220px;" class="menu_item">
			<a href="/em-seu-site">Coloque retroLink em seu site</a>
		</div>
		<div style="width: 100px;" class="menu_item">
			<a href="mailto:contato@retrolink.com.br">Fale conosco</a>
		</div>
	</div>
	-->
	
	<div id="irtopo">
		<img title="Topo Página" src="/static/img/irtopo.png" />
	</div>
		<div class="pagina">
			<div class="comoFunciona">
				<h1><a href="http://www.twitter.com/retrolinkbrasil" target="_blank" title="Siga-nos no twitter" rel="nofollow">retr<em>o</em>Link</a></h1>
				<em class="descricao">
					Acabe com os <strong>protetores de links</strong> com apenas <strong>um clique</strong>
					<br />
					Instale agora o <strong>retroLink</strong> em seu navegador.
				</em>
				<img src="/static/img/como-funciona.png" alt="Como funciona" class="comoFunciona" width="351" height="73" />
				<ul>
					<div id="redes-sociais" style="padding-top:20px; display:none">
						<a href="http://twitter.com/share?url=http://retrolink.com.br/" class="twitter-share-button" data-count="horizontal" data-via="retrolinkbrasil" rel="me" data-text="Esqueça os links protegidos e faça downloads tranquilamente">Tweet</a>
						<script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
						<iframe src="http://www.facebook.com/plugins/like.php?href=http://retrolink.com.br&send=false&layout=button_count&show_faces=false&action=like&colorscheme=light&font" scrolling="no" frameborder="0" style="border:none; overflow:hidden;height:21px;width:96px;padding-right: 10px" allowTransparency="true"></iframe>
						<script type="text/javascript" src="http://apis.google.com/js/plusone.js"></script>
						<g:plusone size="medium"></g:plusone>
					</div>
				</ul>
				<ul class="navegadores">
					<li class="chrome">
						<a href="https://chrome.google.com/webstore/detail/fialekndleeclflilkpdcgdbboiibdab" title="Instalar o retroLink no seu Google Chrome" rel="nofollow" target="_blank">
							<strong>Chrome</strong>
							<span>Add plugin</span>
						</a>
					</li>
					<li class="firefox">
						<a href="https://addons.mozilla.org/pt-BR/firefox/addon/retrolink/" title="Instalar o retroLink no seu Firefox" rel="nofollow" target="_blank">
							<strong>Firefox</strong>
							<span>Add plugin</span>
						</a>
					</li>
					<li class="opera">
						<a href="https://addons.opera.com/addons/extensions/details/retrolink/1.0/?display=pt_br" title="Instalar o retroLink no seu Opera" rel="nofollow" target="_blank">
							<strong>Opera</strong>
							<span>Add plugin</span>
						</a>
					</li>
					<li class="ie">
						<a href="http://retrolink.com.br/retrolink-ie.1.0.exe" title="Instalar o retroLink no seu Internet Explorer" rel="nofollow">
							<strong>Explorer</strong>
							<span>Add plugin</span>
						</a>
					</li>
					<li class="safari">
						<a href="http://retrolink.com.br/retrolink.safariextz" title="Instalar o retroLink no seu Safari" rel="nofollow">
							<strong>Safari</strong>
							<span>Add plugin</span>
						</a>
					</li>
				</ul>
				<div class="desprotegerManual">
					<form id="formbusca" method="post">
						<fieldset>
							<h3>Desproteja os links</h3>
							<ol>
								<li class="url">
									<label>URL:</label>
									<input id="campourl" onClick="select()" type="text" class="txt" value="http://" autocomplete="off" />
									<button id="verificar" class="botao" type="submit">Desproteger</button>
									<button id="limpar" class="limpar" style="display:none" title="limpar campo"></button>
								</li>
							</ol>
						</fieldset>
					</form>
				</div>
				<div style="display:none; padding-left:280px; font-size:12px;" id="resultado"></div>
				<div class="borda"></div>
			</div>
			<div class="maisBaixados">
				<h2>Até o momento desprotegemos <span id="contador" style="font: 40px/30px unProtector_1, Helvetica, Arial, Sans-Serif; letter-spacing: -2px; font-weight: bold;"><!--#include file="inc/counter.asp"--></span> links protegidos, esperamos crescer a cada dia! obrigado a todos.</h2>
			</div>
			<div class="comentarios">
				<a href="http://twitter.com/home?status=Esqueça%20os%20links%20protegidos%20e%20faça%20downloads%20tranquilamente%20-%20http://goo.gl/kIexU%20(via%20@retrolinkbrasil)" class="twitter" target="_blank" title="Siga-nos os bons!" rel="nofollow">Siga-nos os bons!</a>
				<div class="borda"></div>
				<div id="disqus_thread" style="width:90%;margin-left:64px;padding-bottom:20px"></div>
				<script type="text/javascript">
					var disqus_shortname = 'retrolink';
					var disqus_url = 'http://retrolink.com.br/';
					(function() {
						var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
						dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
						(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
					})();
				</script>
			</div>
		</div>

		<div style="display:none">
			<div id="inline" style="padding:10px; background:#fff; font:11px/1.1 Verdana, sans-serif;">
				<p><span style="font-size:14px; font-weight: bold">Por que minha url não foi desprotegida?</span></p>
				<br />
				<p>Se a URL não foi desprotegida. Verifique se ela esta correta, ou aguarde até que o retroLink seja atualizado para compreender o novo protetor de links.</p>
				<br />
				<p>Alguns sites usam dois protetores de link ao mesmo tempo. Pode ser necessário desproteger a URL duas (ou mais) vezes, através do retroLink.com.br.</p>
				<br />
				<p>Algumas URLs parecem protetores de link, mas na realidade não protegem nenhum download. Existem apenas para enganar os usuários. Em alguns casos o sistema alertara o usuário, porém em outros só aparecera uma mensagem dizendo que não foi possível fazer a desproteção.</p>
				<br />
				<p>A URL que precisa ser inserida no retroLink é a URL onde o protetor de link efetivamente é mostrado para você, e não a URL do blog ou da página onde você encontrou os links para download.</p>
			</div>
		</div>
		
		<img src="http://whos.amung.us/swidget/p8s0p8fyo90k/" width="80" height="15" border="0" style="display:none;" />
		
		<script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-34397595-1']);
		  _gaq.push(['_trackPageview']);

		  (function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		</script>

	</body>
</html>