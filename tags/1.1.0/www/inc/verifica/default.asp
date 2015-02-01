<%
'esse abaixo é necessario por conta do unicode da page bitshare que tava dando erro, dai eu tratar todas com este.
Function BinToText(varBinData, intDataSizeInBytes)

	Const adFldLong = &H00000080
	Const adVarChar = 200

	Set objRS = Server.CreateObject("ADODB.Recordset")

	objRS.Fields.Append "txt", adVarChar, intDataSizeInBytes, adFldLong
	objRS.Open

	objRS.AddNew
	objRS.Fields("txt").AppendChunk varBinData
	BinToText = objRS("txt").Value

	objRS.Close
	Set objRS = Nothing

End Function

Function VerificaServidor(url)
   if instr(url,"2shared.com")       then define = "2shared"       : VerificaServidor = ChecaLink(url,define)
   if instr(url,"easy-share.com")    then define = "easy-share"    : VerificaServidor = ChecaLink(url,define)
   if instr(url,"filebase.to")       then define = "filebase"      : VerificaServidor = ChecaLink(url,define)
   if instr(url,"fileserve.com")     then define = "fileserve"     : VerificaServidor = ChecaLink(url,define)
   if instr(url,"hotfile.com")       then define = "hotfile"       : VerificaServidor = ChecaLink(url,define)
   if instr(url,"megaupload.com")    then define = "megaupload"    : VerificaServidor = ChecaLink(url,define)
   if instr(url,"filesonic.com")     then define = "filesonic"     : VerificaServidor = ChecaLink(url,define)
   if instr(url,"bitshare.com")      then define = "bitshare"      : VerificaServidor = ChecaLink(url,define)
   if instr(url,"badongo.com")       then define = "badongo"       : VerificaServidor = ChecaLink(url,define)
   if instr(url,"4shared.com")       then define = "4shared"       : VerificaServidor = ChecaLink(url,define)
   if instr(url,"uploading.com")     then define = "uploading"     : VerificaServidor = ChecaLink(url,define)
   if instr(url,"mediafire.com")     then define = "mediafire"     : VerificaServidor = ChecaLink(url,define)
   if instr(url,"depositfiles.com")  then define = "depositfiles"  : VerificaServidor = ChecaLink(url,define)
   if instr(url,"ziddu.com")         then define = "ziddu"         : VerificaServidor = ChecaLink(url,define)
   if instr(url,"uploadstation.com") then define = "uploadstation" : VerificaServidor = ChecaLink(url,define)
   if instr(url,"uploaded.to")       then define = "uploaded"      : VerificaServidor = ChecaLink(url,define)
End Function

Function ChecaLink(url,servidor)

	select case servidor
		case "2shared"       : define = "File type"
		case "easy-share"    : define = "firstTimer();"
		case "filebase"      : define = "Download:"
		case "fileserve"     : define = "<div class=""panel file_download"">"
		case "hotfile"       : define = "download_file"
		case "megaupload"    : define = "download_file_name"
		case "filesonic"     : define = "Filename:"
		case "bitshare"      : define = "class=""download"""
		case "badongo"       : define = "Uploaded by"
		case "4shared"       : define = "<h1 id=""fileNameText"">"
		case "uploading"     : define = "name=""file_id"""
		case "mediafire"     : define = "class=""download_file_title"""
		case "depositfiles"  : define = "<div class=""downloadblock"">"
		case "ziddu"         : define = "value=""Download"""
		case "uploadstation" : define = "class=""download_item"""
		case "uploaded"      : define = "Download file:"
	end select

	dim xmlhttp : set xmlhttp = Server.CreateObject("Microsoft.XMLHTTP")

	xmlhttp.Open "GET", url, false
	xmlhttp.Send Cstr(Rnd())

	Dim codigo : codigo = BinToText(xmlhttp.ResponseBody,35000)

	if instr(codigo,define) then
		ChecaLink = "<img src='/static/img/arquivo_online.png' style='float: left; padding-bottom:2px;padding-right:4px'>" &_
        "Ae!!! o arquivo encontra-se <strong>disponível para download</strong>!!!" &_
		"<script>link_quebrado('online');</script>"
	else
		ChecaLink = "<img src='/static/img/arquivo_offline.png' style='float: left; padding-bottom:2px;padding-right:4px'>" &_
        "Aff... Infelizmente o arquivo esta quebrado, <a href=""javascript:linkquebrado();"" class=""errodownload""><strong>clique aqui</strong></a> para informações :(" &_
		"<script>link_quebrado('offline');</script>"
	end if

	set xmlhttp = nothing

End Function

dim link : link = request.form("link")

Response.Write VerificaServidor(link)
%>