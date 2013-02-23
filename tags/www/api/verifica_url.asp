<%
' ------------------------
' @ checkHttp(url)
' Verifica se a url esta correta em relação ao http... se tiver algo errado o sistema colocar o http...
' ------------------------
Function checkHttp(url)
	vUrl = trim(left(url,7))
	if left(vUrl,6)  = "ttp://"  then
		checkHttp = "h" & url
		elseif left(vUrl,5)  = "tp://"   then : checkHttp = "ht"      & url
		elseif left(vUrl,4)  = "p://"    then : checkHttp = "htt"     & url
		elseif left(vUrl,3)  = "://"     then : checkHttp = "http"    & url
		elseif left(vUrl,2)  = "//"      then : checkHttp = "http:"   & url
		elseif left(vUrl,1)  = "/"       then : checkHttp = "http:/"  & url
		elseif mid(url,8,7)  = "http://" then : checkHttp = mid(url,8)
		elseif left(vUrl,7)  = "http://" then : checkHttp = url
		elseif instr(url,"https://")     then : checkHttp = url
	else
		checkHttp = "http://" & url
	end if
End Function

' ------------------------
' @ IsValidUrl(url)
' Verifica através de expressão regular se o campo é ou não uma url válida
' ------------------------
Function IsValidUrl(url)
	url = checkHttp(url)
    Set regEx = New RegExp
    regEx.Pattern = "(http|ftp|https)://([\w-]+\.)+(/[\w- ./?%&=]*)?"
    IsValidUrl = regEx.Test(trim(url))
End Function

' ------------------------
' @ analisa_fraudulento(url)
' Analisa o campo postado pelo usuário e se for confirmado chama o alerta
' ------------------------
Function analisa_fraudulento(url)
	divideUrl = trim(left(url,40))
	if instr(divideUrl,"armagedomfilmes.biz") then
		call alerta_fraudulento("Armagedom Filmes")
		elseif instr(divideUrl,"jogoscelular.net/Download.html") then : call alerta_fraudulento("Jogos Celular")
		elseif instr(divideUrl,"fileups.net/")                   then : call alerta_fraudulento("File Ups")
		elseif instr(divideUrl,"flycell.com.br")                 then : call alerta_fraudulento("Flycell")
		elseif instr(divideUrl,"sharecash.org")                  then : call alerta_fraudulento("Share Cash")
		elseif instr(divideUrl,"fileace.com")                    then : call alerta_fraudulento("File Ace")
		elseif instr(divideUrl,"flycell.com")                    then : call alerta_fraudulento("Fly Cell")
		elseif instr(divideUrl,"protetor-de-link.blogspot.com")  then : call alerta_fraudulento("Protetor de link no Blogspot")
		elseif instr(divideUrl,"offers.motime.com.br")           then : call alerta_fraudulento("Motime")
		elseif instr(divideUrl,"k2downloads.info")               then : call alerta_fraudulento("k2 Downloads")
	end if
End Function

' ------------------------
' @ url_sem_nocao(url)
' verifico se o usuário postou uma url sem noção e alerto ele sugerindo o site
' ------------------------
Function url_sem_nocao(url)
	divideUrl = trim(left(url,40))
	if instr(divideUrl,"globo.com") then
		call alerta_url_sem_nocao("http://globo.com","Globo")
		elseif instr(divideUrl,"uol.com.br")   then : call alerta_url_sem_nocao("http://uol.com.br","Uol")
		elseif instr(divideUrl,"hotmail.com")  then : call alerta_url_sem_nocao("http://hotmail.com.br","Hotmail")
		elseif instr(divideUrl,"gmail.com")    then : call alerta_url_sem_nocao("http://gmail.com","Gmail")
		elseif instr(divideUrl,"yahoo.com")    then : call alerta_url_sem_nocao("http://yahoo.com.br","Yahoo")
		elseif instr(divideUrl,"bol.com")      then : call alerta_url_sem_nocao("http://bol.com.br","Bol")
		elseif instr(divideUrl,"terra.com.br") then : call alerta_url_sem_nocao("http://terra.com.br","Terra")
		elseif instr(divideUrl,"google.com")   then : call alerta_url_sem_nocao("http://google.com.br","Google")
		elseif instr(divideUrl,"facebook.com") then : call alerta_url_sem_nocao("http://facebook.com","Facebook")
		elseif instr(divideUrl,"orkut.com")    then : call alerta_url_sem_nocao("http://orkut.com.br","Orkut")
		elseif instr(divideUrl,"twitter.com")  then : call alerta_url_sem_nocao("http://twitter.com","Twitter")
	end if
End Function

' ------------------------
' @ servidores_download(url)
' verifica se a url apresentada é sobre um serviço de armazenamento de arquivos, megaupload, rapidshare...
' ------------------------
Function servidores_download(url)
	divideUrl = trim(left(url,40))
	if instr(divideUrl,"2shared.com") then
		call alerta_servidores_download("2shared")
		elseif instr(divideUrl,"easy-share.com")    then : call alerta_servidores_download("easyshare")
		elseif instr(divideUrl,"filebase.to")       then : call alerta_servidores_download("filebase")
		elseif instr(divideUrl,"fileserve.com")     then : call alerta_servidores_download("fileserve")
		elseif instr(divideUrl,"hotfile.com")       then : call alerta_servidores_download("hotfile")
		elseif instr(divideUrl,"megaupload.com")    then : call alerta_servidores_download("megaupload")
		elseif instr(divideUrl,"filesonic.com")     then : call alerta_servidores_download("filesonic")
		elseif instr(divideUrl,"bitshare.com")      then : call alerta_servidores_download("bitshare")
		elseif instr(divideUrl,"badongo.com")       then : call alerta_servidores_download("badongo")
		elseif instr(divideUrl,"4shared.com")       then : call alerta_servidores_download("4shared")
		elseif instr(divideUrl,"uploading.com")     then : call alerta_servidores_download("uploading")
		elseif instr(divideUrl,"mediafire.com")     then : call alerta_servidores_download("mediafire")
		elseif instr(divideUrl,"depositfiles.com")  then : call alerta_servidores_download("depositfiles")
		elseif instr(divideUrl,"ziddu.com")         then : call alerta_servidores_download("ziddu")
		elseif instr(divideUrl,"uploadstation.com") then : call alerta_servidores_download("uploadstation")
		elseif instr(divideUrl,"uploaded.to")       then : call alerta_servidores_download("uploaded")
	end if
End Function

' ------------------------
' @ adfly(url)
' verifico se a url desprotegida é ou não do adf.ly se for eu entro nela e pego a url correta, sem a necessidade do usuário passar pelos 10 seg.
' Usada em: /api/alertas.asp
' ------------------------
Function adfly(url)
	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()
	codigo = objXMLHTTP.ResponseText
	set objXMLHTTP = nothing
	if instr(codigo,"var url = '") then
		antes    = "var url = '"
		depois   = "_.G(""skip_button"").href"
		codigo   = Replace(codigo,antes,"##")
		codigo   = Replace(codigo,depois,"##")
		prepara  = split(codigo,"##")
		separado = prepara(1)
		urlnova  = split(separado,"';")
		adfly    = "http://adf.ly" & urlnova(0)
	else
		adfly    = url
	end if
End Function

' ------------------------
' @ url_encurtada(url)
' se for um encurtador de url tipo o goo.gl eu vo la e pega a url correta
' Usada em: /api/alertas.asp
' ------------------------
Function url_encurtada(url)
	montaurl = "http://retrolink.com.br/inc/pagina.php?url="&url&""
	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	objXMLHTTP.open "GET", montaurl, false
	objXMLHTTP.send()
	pegou_url = objXMLHTTP.ResponseText
	url_encurtada = pegou_url
	set objXMLHTTP = nothing
End Function

' ------------------------
' @ encurtador(url)
' verifico a url postada pelo usuário se for sistema comprimido em faço a verificação
' Usada em: /api/alertas.asp
' ------------------------
function encurtador(url)

	urlencurtada = left(url,20)

	if instr(urlencurtada,"http://goo.gl/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://migre.me/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://bit.ly/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://ul.to/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://tinyurl.com/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://seg.me/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://linksafe.me/d/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	elseif instr(urlencurtada,"http://gd.is/") then
		vUrl = url_encurtada(url)
		call alerta_encurtador(vUrl)
	end if

end function
%>