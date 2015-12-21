
var disqus_shortname = 'retrolink';
var disqus_url = 'http://retrolink.com.br/';
(function() {
	var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
	dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
	(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();

$(document).ready(function(){

	$('#redes-sociais').fadeIn(800);

	$(window).scroll(function(){
		if ($(this).scrollTop() != 0){
			$('#irtopo').stop().animate({'right': 0});
		} else {
			$('#irtopo').stop().animate({'right': '-38px'});
		}
	});

	$('#irtopo').click(function(){
		$('body,html').animate({scrollTop:0},900);
	});

	$('#formbusca').submit(function() {

		$('#verificar').removeClass('sucesso');
		$('#verificar').removeClass('erro');

		var links = $('#campourl').val();

		if (links == 'http://') {
			$('#verificar').addClass('sucesso');
			Growl('Ocorreu um erro', 'É necessário utilizar uma url válida. Por favor, tente novamente.', 'ff0000', false);
			return false;
		} else if (links == ''){
			$('#verificar').addClass('sucesso');
			Growl('Ocorreu um erro', 'É necessário especificar a url que deseja desproteger. Por favor, tente novamente.', 'ff0000', false);
			return false;
		} else if (links !== '') {

			$('#verificar').addClass('aguarde');
			$('#verificar').html('Aguarde...');
			$('#verificar').attr('disabled', true);

			$('#campourl').attr('disabled', true);

			$('#resultado').fadeIn(800).html('<img src="/static/img/loading.gif" style="float: left; padding-right:4px">Aguarde, estamos verificando seu link...')
			$.post('/api/',{url:links},
			function(data){
				$('#resultado').html(data);
				$('#verificar').addClass('sucesso');
				$('#verificar').html('Desproteger');
				$('#limpar').fadeIn(800);
				$('#campourl').removeAttr('disabled');
				$('#verificar').removeAttr('disabled');
				//contador();
			});
			return false;
		}

	});

	$('#limpar').click(function() {
		$('#campourl').val('http://');
		$('#resultado').fadeOut();
		$('#limpar').fadeOut(800);
		$.gritter.removeAll();
		return false;
	});

});

//function gritter
function Growl(n_title, n_msg, color, fixed) {
	color = color || 'aefd8e';
	fixed = fixed || false;
	$.gritter.add({
		title: '<span style="color: #"' + color + '">' + n_title + '</span>',
		text: n_msg,
		sticky: fixed
	});
}

function alerta_colorbox(url) {
	
	$.colorbox({width:'50%', inline:true, href:'#'+url});
	
}

function alerta() {
	$.colorbox({width:'50%', inline:true, href:'#inline'});
}

function fraudulento() {
	$.colorbox({href:'/boxes/box_fraudulento.html', width:'50%'});
}

function linkquebrado() {
	$.colorbox({href:'/boxes/box_linkquebrado.html', width:'50%'});
}