
	var disqus_shortname = 'retrolink';
	var disqus_url = 'http://retrolink.com.br/';
	(function() {
		var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
		dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
		(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	})();

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
	//setInterval(contador,10000);

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