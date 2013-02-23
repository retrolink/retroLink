<%
Function alerta_sucesso(url)

	'algumas urls vem com 2 protetores e algumas utilizam o seguintes urls que eu vou tratar por replace
	url = replace(url,"�","")
	url = replace(url,"http://linkprotetor.com/download/?url=","")
	url = replace(url,"http://somniu.net/protetor/down/?url$","")
	url = replace(url,"http://www.xerox66.com/cadastre-se_abaixo_para_ajudar_o_site_/?url=","")
	url = replace(url,"http://indica.celularbr.com/?","")
	url = replace(url,"http://telona.biz/clique-para-baixar/download/?url=","")
	url = replace(url,"http://clubedodownload.info/link/?url=","")
	url = replace(url,"opot#","")
	url = replace(url,"/daolnwod/gro.seiresesemlifraxiab.www//:ptt","")
	url = replace(url,"http://www.detonagames.com/?url=","")
	url = replace(url,"http://musicasdegraca.com/download/?url=","")
	url = replace(url,"http://baixebr.org/download/?","")
	url = replace(url,"http://www.baixeja.com/download/?url=","")
	url = replace(url,"http://protetor.baixemusicas.net/?url=","")
	url = replace(url,"http://www.linkagratis.info/download/?url=","")
	url = replace(url,"http://www.entretenimento.blog.br/links/down.php?url=","")
	url = replace(url,"http://www.jogosorkut.com/get.php?goto=","")
	url = replace(url,"http://anonym.to/?","")
	url = replace(url,"http://www.liberadosfree.info/download/down.php?url=","")
	url = replace(url,"http://www.superdownload.us/link/?url=","")
	url = replace(url,"http://www.baixar-filmes-gratis.com/download/?url=","")
	url = replace(url,"http://www.securitylink.info/link/?url","")
	url = replace(url,"http://www.filmesrmvbgratis.com/download/?link=","")
	url = replace(url,"http://link.justfilmeseseriados.com/?url=","")
	url = replace(url,"#","")
	url = replace(url,""" checked=""checked","")
	
	url = URLDecode(url)
	
	url = replace(url," ","")

	'aqui eu faço o log de gravação de sucesso no bd
	call registra(url,protegida,addon,1)

	'encurto a url para fazer algumas configurações
	urlencurtada = left(url,20)
	
	'faço a verificação do adf.ly aqui para se for true jogar a url correta na api dos navegadores.
	'utiliza a function adfly(url) que esta em /api/verifica_url.asp
	if instr(urlencurtada,"http://adf.ly/") then
		vUrl = adfly(url)
	else
		vUrl = url
	end if
	
	'caso a addon chamativa não for pelo site, ele simplesmente redireciona a page
	if addon <> "site" then 
		Response.Redirect(vUrl)
		Response.End()
	end if
	
	'faço a verificação para saber se o resultado da url é um encurtador, se for eu mando a função para descobrir a url verdadeira
	'utiliza a function url_encurtada que esta em /api/verifica_url.asp
	if instr(urlencurtada,"http://goo.gl/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://migre.me/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://bit.ly/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://ul.to/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://tinyurl.com/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://seg.me/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://linksafe.me/d/") then
		vUrl = url_encurtada(url)
	elseif instr(urlencurtada,"http://gd.is/") then
		vUrl = url_encurtada(url)
	end if

	Response.Write "<font size=""4"">Link desprotegido com sucesso!</font>" &_
	"<br /><br />" &_
	"<img src=""/static/img/valid.png"" style=""float:left;"">" &_
	"<span style=""padding-left:6px""><a href="""&vUrl&""" class=""urldownload"" title="""&vUrl&""" target=""_blank"">"&pontinhos(vUrl,65)&"</a> - <a href=""#"" class=""urldownload"" id=""copia-url"">(Copiar URL)</a></span>" &_
	"<script type=""text/javascript"">" &_
	"	Growl('Sucesso!', 'Sua url foi desprotegida com sucesso! Agradeça divulgando nosso serviço!', '00FF00', false);" &_
	"</script>" &_
	"<div id=""url"" style=""display:none"">"&vUrl&"</div>"

	'toda vez que eu adicionar aqui novos servidores eu tenho que atualizar tb em inc/verifica/default.asp

	urlservidor = trim(left(vUrl,40))

	if instr(urlservidor,"2shared.com")       then : servidor = "2shared"
	if instr(urlservidor,"easy-share.com")    then : servidor = "easy-share"
	if instr(urlservidor,"filebase.to")       then : servidor = "filebase"
	if instr(urlservidor,"fileserve.com")     then : servidor = "fileserve"
	if instr(urlservidor,"hotfile.com")       then : servidor = "hotfile"
	if instr(urlservidor,"megaupload.com")    then : servidor = "megaupload"
	if instr(urlservidor,"filesonic.com")     then : servidor = "filesonic"
	if instr(urlservidor,"bitshare.com")      then : servidor = "bitshare"
	if instr(urlservidor,"badongo.com")       then : servidor = "badongo"
	if instr(urlservidor,"4shared.com")       then : servidor = "4shared"
	if instr(urlservidor,"uploading.com")     then : servidor = "uploading"
	if instr(urlservidor,"mediafire.com")     then : servidor = "mediafire"
	if instr(urlservidor,"depositfiles.com")  then : servidor = "depositfiles"
	if instr(urlservidor,"ziddu.com")         then : servidor = "ziddu"
	if instr(urlservidor,"uploadstation.com") then : servidor = "uploadstation"
	if instr(urlservidor,"uploaded.to")       then : servidor = "uploaded"

	if servidor <> "" then
		Response.Write "<br /><br />"
		Response.Write "<span id=""verifica_arquivo"">"
		Response.Write "<img src='/static/img/loading.gif' style='float: left; padding-right:4px'>"
		Response.Write "Arquivo hospedado no <strong><u>"&servidor&"</u></strong>, verificando se ele esta ativo ou quebrado, aguarde..."
		Response.Write "</span>"
		Response.Write "<script>verifica_link('"&vUrl&"');</script>"
	end if

End Function


' ------------------------
' @ alerta_encurtador(url)
' faço a verificação para descobrir a url correta, trabalo em conjunto com a funcion encurtador(url) /api/verifica_url.asp
' Quando atualizar aqui tenho que atualizar tb em /api/verifica_url.asp na function encurtador(url)
' ------------------------
function alerta_encurtador(url)
	
	urlencurtada = left(url,20)
	
	alertaerro = "<font size=""4"">Algo esta errado... :(</font>" +_
	"<br /><br />" +_
	"<img src=""/static/img/invalid.png"" style=""float:left; padding-right:6px"">" +_
	"Não foi possível <strong>descompactar</strong> sua url, por favor <strong>verifique</strong> e tente novamente!"
	
	alertasucesso = "<font size=""4"">Url descompactada com sucesso! :D</font>" +_
	"<br /><br />" +_
	"<img src=""/static/img/valid.png"" style=""float:left; padding-right:6px"">" +_
	"<a href="""&url&""" class=""urldownload"" title="""&url&""" target=""_blank"">"&pontinhos(url,95)&"</a>"
	
	'se chegar aqui é porque aconteceu um erro dai eu emito um alerta.
	if instr(urlencurtada,"http://goo.gl/") then
		response.write(alertaerro)
	elseif instr(urlencurtada,"http://migre.me/") then
		response.write(alertaerro)
	elseif instr(urlencurtada,"http://bit.ly/") then
		response.write(alertaerro)
	elseif instr(urlencurtada,"http://ul.to/") then
		response.write alertaerro
	elseif instr(urlencurtada,"http://tinyurl.com/") then
		response.write alertaerro
	elseif instr(urlencurtada,"http://seg.me/") then
		response.write alertaerro
	elseif instr(urlencurtada,"http://linksafe.me/d/") then
		response.write alertaerro
	elseif instr(urlencurtada,"http://gd.is/") then
		response.write alertaerro
	else
		response.write(alertasucesso)
	end if

	response.end

end function

Function alerta_erro()
	call registra(url,protegida,addon,2)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('Esta url não é suportada... para maiores informações veja a lista de sites suportados pelo sistema, na página do addon.');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
		Response.End()
	end if
	Response.Write("<img src=""/static/img/invalid.png"" style=""float:left; padding-right:6px"">Não foi possível desproteger esta url, <a href=""javascript:alerta_colorbox('inline',2,'50%',0);"" class=""errodownload"">clique aqui</a> e saiba as possíveis causas para isso.")
	Response.Write "<br /><br />"
	Response.Write "<img src=""/static/img/movies.png"" style=""float:left; padding-right:6px"">"
	Response.Write "Caso ainda esteja com dúvidas, <a href=""javascript:alerta_colorbox('box_video_youtube',3,483,393);"" class=""errodownload""><strong>clique aqui</strong></a> e saiba como utilizar o sistema."
End Function

Function alerta_incorreta(url)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('Esta não é uma url válida, por favor verifique e tente novamente!');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
		Response.End()
	end if
	Response.Write "<img src=""/static/img/invalid.png"" style=""float:left; padding-right:6px"">"
	Response.Write "<strong>'" & url & "'</strong> não é uma url válida! em caso de dúvidas <a href=""javascript:alerta_colorbox('inline',2,'50%',0);"" class=""errodownload"">clique aqui</a>." &_
	"<script type=""text/javascript"">" &_
	"	Growl('Ocorreu um erro', 'Por favor, utilize uma url válida, tente novamente...', 'ff0000', false);" &_
	"</script>"
	Response.Write "<br /><br />"
	Response.Write "<img src=""/static/img/movies.png"" style=""float:left; padding-right:6px"">"
	Response.Write "Caso ainda esteja com dúvidas, <a href=""javascript:alerta_colorbox('box_video_youtube',3,483,393);"" class=""errodownload""><strong>clique aqui</strong></a> e saiba como utilizar o sistema."
End Function

Function alerta_urlretro(url)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('A url do retroLink não é protegida... dãããããã!');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
	end if
	Response.Write "<strong>'" & url & "'</strong> a url do retroLink, não é protegida...." &_
	"<script type=""text/javascript"">" &_
	"	Growl('Ocorreu um erro', 'A url do retroLink não é protegida... dãããããã!', 'ff0000', false);" &_
	"</script>"
End Function

Function alerta_fraudulento(nsite)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('Consta em nosso sistema que o site "&nsite&", é fraudulento pois exibe apenas propaganda... portanto, nada feito :/');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
	end if
	Response.Write "Consta em nosso sistema que o site <strong>"&nsite&"</strong>, é fraudulento, <a href=""javascript:fraudulento();"" class=""errodownload"">clique aqui</a> para mais informações" &_
	"<script type=""text/javascript"">" &_
	"	Growl('Ocorreu um erro', 'Site fraudulento detectado!', 'ff0000', false);" &_
	"</script>"
	Response.end()
	exit function
End Function

Function alerta_url_sem_nocao(url,nsite)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('Esta não é uma url válida, por favor verifique e tente novamente!');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
	end if
	Response.Write "<img src=""/static/img/invalid.png"" style=""float:left; padding-right:6px"">"
	Response.Write "Essa ferramente é para <strong>desproteção de links</strong>, caso queira acessar o site <strong>"&nsite&"</strong> <a href="""&url&""" class=""urldownload"" title="""&url&""" target=""_blank"">clique aqui...</a>"
	Response.Write "<br /><br />"
	Response.Write "<img src=""/static/img/movies.png"" style=""float:left; padding-right:6px"">"
	Response.Write "Caso ainda esteja com dúvidas, <a href=""javascript:alerta_colorbox('box_video_youtube',3,483,393);"" class=""errodownload""><strong>clique aqui</strong></a> e saiba como utilizar o sistema."
	Response.end()
	exit function
End Function

Function alerta_servidores_download(nsite)
	if addon <> "site" then
		Response.Write("<script type=""text/javascript"">") & vbLF
		Response.Write("	alert('Esta não é uma url válida, por favor verifique e tente novamente!');") & vbLF
		Response.Write("	" & redir_addon(addon) & "") & vbLF
		Response.Write("</script>")
	end if
	Response.Write "<img src=""/static/img/invalid.png"" style=""float:left; padding-right:6px"">"
	Response.Write "A url do <strong>"& nsite &"</strong> não esta protegida, <a href=""javascript:alerta_colorbox('box_servidor_download',1,0,0);"" class=""errodownload"">clique aqui</a> para mais informações."
	Response.Write "<br /><br />"
	Response.Write "<img src=""/static/img/movies.png"" style=""float:left; padding-right:6px"">"
	Response.Write "Caso ainda esteja com dúvidas, <a href=""javascript:alerta_colorbox('box_video_youtube',3,483,393);"" class=""errodownload""><strong>clique aqui</strong></a> e saiba como utilizar o sistema."
	Response.end()
	exit function
End Function
%>