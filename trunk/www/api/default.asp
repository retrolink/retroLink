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
<!--#include file="bd.asp"-->
<!--#include file="funcoes.asp"-->
<!--#include file="verifica_url.asp"-->
<!--#include file="alertas.asp"-->
<!--#include file="decodes.asp"-->
<script type="text/javascript" src="/static/javascript/jquery.zclip.min.js"></script>
<script type="text/javascript">
	$("a#copia-url").zclip({path:'/static/swf/ZeroClipboard.swf', copy:$('#url').text()});
</script>
<%
On Error Resume Next

Response.Charset = "utf-8"

vAddon  = request.querystring("addon")
vVersao = request.querystring("versao")

If vAddon = "chrome" then
   addon = "chrome"
ElseIf vAddon = "firefox" then : addon = "firefox"
ElseIf vAddon = "opera"   then : addon = "opera"
ElseIf vAddon = "ie"      then : addon = "ie"
ElseIf vAddon = "safari"  then : addon = "safari"
Else
   addon = "site"
End if

if addon = "site" then
	cUrl = Trim(removeAllTags(Request.Form("links")))
Else
	cUrl = Trim(removeAllTags(Request.QueryString("url")))
End If

cUrl = replace(cUrl," ","")
cUrl = replace(cUrl,"ABC123CBA","")
cUrl = replace(cUrl,"?ANTES DE FAZER O DOWNLOAD CADASTRSE SEU CELULAR, E RECEBA TOQUES MP3 ANTES DE FAZER O DOWNLOAD CADASTRSE SEU CELULAR, E RECEBA TOQUES MP3?m=1, ","?url=")
cUrl = replace(cUrl,"aHR0cDovL3d3dy5yZWVsaGQuY29tLmJyL2lyL3NsLz91cmw9","")
cUrl = replace(cUrl,"aHR0cDovL3Byb3RlY3RsaW5rLnVzL2ZiLz91cmw9","")
cUrl = replace(cUrl,"http://www.baixandonanet.com/blog2/?url=","")
cUrl = replace(cUrl,"aHR0cDovL3RyYWNrLm96b25pb24uY29tL2FmZl9jP29mZmVyX2lkPTIxJmFmZl9pZD0xMjcaHR0cDovL3RyYWNrLm96b25pb24uY29tL2FmZl9jP29mZmVyX2lkPTIxJmFmZl9pZD0xMjc, ","")
cUrl = replace(cUrl,"687474703a2f2f7777772e696e666f6469676974616c2e6f72672f646f776e6c6f61642f3f75726c3d","") 
cUrl = replace(cUrl,"http://direcionando.baixedetudo.net/link/?url=http://direcionando.baixedetudo.net/link/?url=","http://direcionando.baixedetudo.net/link/?url=")
cUrl = replace(cUrl,"687474703a2f2f7777772e636163686f72726f6c6f75636f2e6e65742f67616c6572696164616d75736963612f3f75726c3d","")
cUrl = replace(cUrl,"aHR0cDovL2Rvd25sb2Fkc2dyYXRpc2NvbXBsZXRvcy5jb20vYmFpeGFyLz91cmw9","")
cUrl = replace(cUrl,"687474703a2f2f646f776e6c6f616473677261746973636f6d706c65746f732e636f6d2f6261697861722f3f75726c3d","")
cUrl = replace(cUrl,"/?url=http://www.telaquente.biz/tq/?link=","/?url=")
cUrl = replace(cUrl,"?url=http://www.baixatudogames.com/download/?url=","?url=")
cUrl = replace(cUrl,"687474703a2f2f7777772e6c6f616462722e696e666f2f6c696e6b2f3f75726c3d","")
cUrl = replace(cUrl,"687474703a2f2f616e6f6e796d6f7573652e6f72672f6367692d62696e2f616e6f6e2d7777772e6367692f","")
cUrl = replace(cUrl,"aHR0cDovL3RyYWNrLm96b25pb24uY29tL2FmZl9jP29mZmVyX2lkPTIxJmFmZl9pZD0xMjc","") 
cUrl = replace(cUrl,"687474703a2f2f636173746f72646f776e6c6f6164732e6e65742f70726f7465746f722f3f75726c3d","")
cUrl = replace(cUrl,"aHR0cDovL/","")
cUrl = replace(cUrl,"687474703a2f2f7777772e616e746970726f7465746f722e636f6d2f646f776e6c6f61642f3f6c696e6b3d","")

protegida = cUrl

'aqui verifico se a url é encurtada
call encurtador(cUrl)

'aqui eu faço a analise para saber se a url postada é sem noção exp: globo.com, uol.com.br, terra.com.br...
call url_sem_nocao(cUrl)

'faço a analise para saber se o site é ou não fraudulento, tem uma lista de sites fraudulentos
call analisa_fraudulento(cUrl)

'faço a analise para saber se o usuário esta tenatndo desproteger uma url de um servidor de arquivos, exp: megaupload, rapidshared...
call servidores_download(cUrl)

'aqui faço a verificação para saber se o usuário não esta tentando desproteger a propria url do desprotetor
if instr(protegida,"retrolink.com.br") then
	if cUrl = "retrolink.com.br" then
		alerta_urlretro("http://" & cUrl)
	else
		alerta_urlretro(cUrl)
	end if
	Response.End()
End if

'faço a verificação para saber se a url é valida ou invalida, se for false eu redireciono a mensagem de erro
If IsValidUrl(cUrl) = false Then
	call alerta_incorreta(cUrl)
	Response.End()
End If

Function reverter_url(url,query)
	url = split(url,query)
	call alerta_sucesso(StrReverse(url(1)))
End Function

'este eu utilizo na versao abaixo da funtion... tenho que verificar se para todo o vamola.in é assim
'http://www.vamola.in/protetor/tara.php?tela=1440&user=filmeja&I9EWG2IP=d?/moc.daolpuagem.www//:ptth
Function url_invertida(url)
	'este replace abaixo serve para tratar a forma com que o site http://filmeseserieshd.com/fs/protetor.php?link=Z@E$83IS2J5C=d?/moc.daolpuagem.www//:ptth usa seu sistema...
	url = replace(url,"Z@E$","")
	url = Replace(url,".url","")
	If instr(url,"?link=") Then
		call reverter_url(url,"?link=")
	ElseIf instr(url,"?url=") Then
		call reverter_url(url,"?url=")
	ElseIf instr(url,"/?") Then
		call reverter_url(url,"/?")
	ElseIf instr(url,".net/") or instr(url,".com/") or instr(url,".info/") or instr(url,".br/") or instr(url,"vamola.in/") Then
		If instr(url,".net/") Then
			call reverter_url(url,".net/")
		ElseIf instr(url,".com/") Then
			call reverter_url(url,".com/")
		ElseIf instr(url,".info/") Then
			call reverter_url(url,".info/")
		ElseIf instr(url,".br/") Then
			call reverter_url(url,".br/")
		ElseIf instr(url,"filmeja&") Then
			call reverter_url(url,"filmeja&")
		Else
			call alerta_erro()
		End If
	Else
		call alerta_erro()
	End If
End Function

Function url_hex(url)
	url = split(url,"687474703a2f2f")
	monta = "687474703a2f2f" & url(1)
	trataex = hexDecode(monta)
	call alerta_sucesso(trataex)
End Function

Function url_base64(url)
	url = split(url,"aHR0cDovL")
	monta = "aHR0cDovL" & url(1)
	monta = Replace(monta,"=/","=")
	base64 = base64_decode(monta)
	call alerta_sucesso(base64)
End Function

'este abaixo faz tres tiradas de base64 o site que utiliza ele é o 
'http://www.listenmusicgospel.com/downloads/?u=WVVoU01HTkViM1pNTTJRelpIazFkRnBYVW5CWlYxcHdZMjFWZFZreU9YUk1lamxzWkRJeGFtUklTblJoVjFFeFlYcGtibUZJVlQwPQ==
Function tres_url_base64(url)
	url = split(url,"WVVoU01HT")
	monta = "WVVoU01HT" & url(1)
	monta = Replace(monta,"=/","=")
	base64_1 = base64_decode(monta)
	base64_2 = base64_decode(base64_1)
	base64_3 = base64_decode(base64_2)
	call alerta_sucesso(base64_3)
End Function

'este abaixo faz um hex decode um base64 e outro hex decode
'http://furiagames360.org/protetor/?a=b&c=d&e=f&f=h&laospqwsado4512asd1=4e6a67334e4463304e7a417a59544a6d4d6d59334e7a63334e7a63795a5459324e6a6b32597a59314e7a4d324e5463794e7a59324e544a6c4e6a4d325a6a5a6b4d6d59324e6a59354e6d4d324e544a6d4e4745304e7a63304d7a6b7a4e5455314e54413d
Function url_hex_base64_hex(url)
	url = split(url,"4e6a67334e4463304e7a417a59544a6d4d6d59")
	monta = "4e6a67334e4463304e7a417a59544a6d4d6d59" & url(1)
	um = hexDecode(monta)
	dois = base64_decode(um)
	tres = hexDecode(dois)
	call alerta_sucesso(tres)
End Function

Function url_simples(url,query)
	url = split(url,query)
	monta = "http://" & url(1)
	call alerta_sucesso(monta)
End Function

Function pqueno(url)
	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()
	codigo = objXMLHTTP.ResponseText
	antes = "<div id=""link"" style=""display: none;"">"
	depois = "<script>contador();</script>"
	codigo = Replace(codigo,antes,"##")
	codigo = Replace(codigo,depois,"##")
	prepara = split(codigo,"##")
	separado = prepara(1)
	pegalink = split(separado,"""")
	set objXMLHTTP = nothing
	call alerta_sucesso(pegalink(1))
End Function

Function clubedownload(url)
	troca = replace(url,".info/",".info/?")
	troca = replace(troca,".url","")
	prepara = split(troca,"info/?")
	If instr(url,"//:ptth") then
		urltratada = StrReverse(prepara(1))
	Else
		urltratada = prepara(1)
	End If
	call alerta_sucesso(urltratada)
End Function

Function url_base64invertida(url)
	pega = split(url,"?")
	resultado = pega(1)
	resultado = Replace(resultado,"link=","")
	base64 = base64_decode(resultado)
	reverte = StrReverse(base64)
	reverte = Replace(reverte,"!og","")
	call alerta_sucesso(reverte)
End Function

Function protetorlink(url)

	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()
	
	codigo = objXMLHTTP.ResponseText
	
	antes = "<div id=""link"" style=""display:none"">"
	depois = "contador();"
	codigo = Replace(codigo,antes,"##")
	codigo = Replace(codigo,depois,"##")
	prepara = split(codigo,"##")
	separado = prepara(1)
	
	an = " href="""
	de = """ target="
	
	separado = Replace(separado,an,"##")
	separado = Replace(separado,de,"##")
	
	trata = split(separado,"##")
	
	set objXMLHTTP = nothing
	
	call alerta_sucesso(trata(1))
	
End Function

Function link_protegido(url)

	pega = split(url,"?link=")
	jogovelha = split(pega(1),"#")
	url = pega(0)
	id = jogovelha(0)

	set objXMLHTTP = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")

	urldominio = url & "trocas.php?link=" & id
	urlreferer = url & "pag.php?link=" & id

	objXMLHTTP.open "GET", urldominio, false
	objXMLHTTP.setRequestHeader "User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
	objXMLHTTP.setRequestHeader "referer", urlreferer
	objXMLHTTP.SetRequestHeader "Host", "www.link-protegido.com"
	objXMLHTTP.send

	codigo = objXMLHTTP.ResponseText

	set objXMLHTTP = nothing
	
	call alerta_sucesso(codigo)	

End Function

Function linkpago(url)

set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()
	
	codigo = objXMLHTTP.ResponseText
	
	antes = "getElementById('download').innerHTML='<a href="""
	depois = """>Clique Aqui para continuar"
	codigo = Replace(codigo,antes,"##")
	codigo = Replace(codigo,depois,"##")
	prepara = split(codigo,"##")
	separado = prepara(1)
	
	set objXMLHTTP = nothing
	
	call alerta_sucesso(separado)

End Function

Function promocoesdeprodutos(url)

	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()

	codigo = objXMLHTTP.ResponseText

	antes = "value=""http://www.promocoesdeprodutos.com/url/url.php?link="
	depois = "<input type=""hidden"" name=""eval"" value=""no"">"
	codigo = Replace(codigo,antes,"##")
	codigo = Replace(codigo,depois,"##")
	prepara = split(codigo,"##")
	separado = prepara(1)
	
	separado = replace(separado,""">","")

	set objXMLHTTP = nothing
	
	call alerta_sucesso(separado)

End Function

'ta dando erro
Function vipDownload(url)

	url = Replace(url,"#","")

	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	
	On Error Resume Next

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()

	codigo = objXMLHTTP.ResponseText
	code = codigo
	
	antes = "setTimeout(""trocaBotao("
	depois = ",'')"","
	codigo = Replace(codigo,antes,"##")
	codigo = Replace(codigo,depois,"##")
	prepara = split(codigo,"##")
	separado = prepara(1)
	
	set objXMLHTTP = nothing
	
	If instr(code,"setTimeout(""trocaBotao(") then
		urlmontada = "http://download.vipdownload.com.br/linkdiscover.php?cod=" & separado
		set objXMLHTTP2 = Server.CreateObject("Microsoft.XMLHTTP")
		objXMLHTTP2.open "POST", urlmontada, false
		objXMLHTTP2.send()
		codigo2 = RemoveWhiteSpace(objXMLHTTP2.ResponseText)
		set objXMLHTTP2 = nothing
		call alerta_sucesso(Trim(codigo2))
	Else 
		call alerta_erro()
	End If

End Function

Function tiodosfilmes(url)

	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	
	On Error Resume Next

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()

	codigo = objXMLHTTP.ResponseText
	
	set objXMLHTTP = nothing
	
	If instr(codigo,"<div id=""MobiMidia_MsgFinal"" style=""visibility:hidden"">") then
		antes = """>http://"
		depois = "</a></p>"
		codigo = Replace(codigo,antes,"##")
		codigo = Replace(codigo,depois,"##")
		prepara = split(codigo,"##")
		separado = prepara(1)
		call alerta_sucesso("http://"&Trim(separado))
	Else
		call alerta_erro()
	End If
	
End Function

Function baxai(url)

	set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
	
	On Error Resume Next

	objXMLHTTP.open "POST", url, false
	objXMLHTTP.send()

	codigo = objXMLHTTP.ResponseText
	
	set objXMLHTTP = nothing
	
	If instr(codigo,"<frame noresize=""noresize"" src=""") then
		antes = "<frame noresize=""noresize"" src="""
		depois = "</frameset>"
		codigo = Replace(codigo,antes,"##")
		codigo = Replace(codigo,depois,"##")
		prepara = split(codigo,"##")
		separado = prepara(1)
		separado = replace(separado,""">","")
		call alerta_sucesso(separado)
	Else
		call alerta_erro()
	End If
	
End Function

Function desprotetor(url)

	set objXMLHTTP = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")

	On Error Resume Next
	
	urldesprotetor = "http://antiprotetor.in/"
	urlreferer     = "http://antiprotetor.in/"

	data = "links="&url&"&save="
	
	objXMLHTTP.open "POST", urldesprotetor, false
	objXMLHTTP.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
	objXMLHTTP.setRequestHeader "User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
	objXMLHTTP.setRequestHeader "referer", urlreferer
	objXMLHTTP.SetRequestHeader "Host", "antiprotetor.in"
	objXMLHTTP.send(data)

	codigo = objXMLHTTP.ResponseText
	
	set objXMLHTTP = nothing
	
	If instr(codigo,"name=""links[]""") then

		antes    = "name=""links[]"" value="""
		depois   = """ /><img"
		codigo   = Replace(codigo,antes,"##")
		codigo   = Replace(codigo,depois,"##")
		prepara  = split(codigo,"##")
		separado = prepara(1)
		
		call alerta_sucesso(Trim(separado))

	else
		call alerta_erro()
	end if

End Function

Function agaleradodownload(url)

	set objXMLHTTP = Server.CreateObject("WinHTTP.WinHTTPRequest.5.1")

	On Error Resume Next
	
	objXMLHTTP.open "POST", url, false
	objXMLHTTP.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
	objXMLHTTP.setRequestHeader "User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
	objXMLHTTP.send()

	codigo = objXMLHTTP.ResponseText
	
	set objXMLHTTP = nothing
	
	If instr(codigo,"var audhaiud") then

		antes    = "var audhaiud = """
		depois   = """; </script>"
		codigo   = Replace(codigo,antes,"##")
		codigo   = Replace(codigo,depois,"##")
		prepara  = split(codigo,"##")
		separado = prepara(1)
		
		call alerta_sucesso(Trim(base64_decode(separado)))

	else
		call alerta_erro()
	end if

End Function

url = cUrl

urlBd = url

if instr(url,"protetor.clubedodownload.info/") then
	call clubedownload(url)
	Elseif instr(url,"baixebr.org/protetor/") then : call desprotetor(url)
	Elseif instr(url,"protetorlink.com/")     then : call protetorlink(url)
	Elseif instr(url,"=http://")              then : call url_simples(url,"=http://")
	Elseif instr(url,"=https://")             then : call url_simples(url,"=https://")
	Elseif instr(url,"/http://")              then : call url_simples(url,"/http://")
	Elseif instr(url,"/https://")             then : call url_simples(url,"/https://")
	Elseif instr(url,"?http://")              then : call url_simples(url,"?http://")
	ElseIf instr(url,"//:ptth")               then : call url_invertida(url)
	ElseIf instr(url,"//:sptth")              then : call url_invertida(url)
	ElseIf instr(url,"pqueno.com/?")          then : call pqueno(url)
	ElseIf instr(url,"687474703a2f2f")        then : call url_hex(url)
	ElseIf instr(url,"aHR0cDovL")             then : call url_base64(url)
	ElseIf instr(url,"Ly86cHR0aA==")          then : call url_base64invertida(url)
	ElseIf instr(url,"Ly86cHR0aA")            then : call url_base64invertida(url)
	ElseIf instr(url,"WVVoU01HT")             then : call tres_url_base64(url)
	ElseIf instr(url,"4e6a67334e4463304e7a417a59544a6d4d6d59") then : call url_hex_base64_hex(url)
	ElseIf instr(url,"linkpago.com/load.php?i=") then : call linkpago(url)
	ElseIf instr(url,"promocoesdeprodutos.com/url/") then : call promocoesdeprodutos(url)
	ElseIf instr(url,"tiodosfilmes.com")      then : call tiodosfilmes(url)
	ElseIf instr(url,"revistasgratis.ws")     then : call tiodosfilmes(url)
	ElseIf instr(url,"baxai.org")             then : call baxai(url)
	ElseIf instr(url,"agaleradodownload.com") then : call agaleradodownload(url)

Else
	call desprotetor(url)
End If

%>