<%

servidor = "localhost"
base     = "retrolin_default"
login    = "retro_default"
senha    = "576118"

'bloqueia um filho da puta que estava utilizando o retrolink em um site.... é osso.
if Request.ServerVariables("REMOTE_ADDR") = "37.59.42.51" then
	Response.Redirect("http://retrolink.com.br")
	Response.End
End If

Function registra(url,protegida,addon,acao)

	If addon = "site" then
		addon = "site"
	Elseif addon = "chrome"  then : addon = "chrome"
	Elseif addon = "firefox" then : addon = "firefox"
	Elseif addon = "opera"   then : addon = "opera"
	ElseIf addon = "ie"      then : addon = "internet explorer"
	ElseIf addon = "safari"  then : addon = "safari"
	End If

	If acao = "sucesso" then
		acao = 1
	ElseIf acao = "erro" then
		acao = 2
	End If

	Set Conn = Server.CreateObject("ADODB.Connection")
	
	Conn.Open("DRIVER={MySQL ODBC 3.51 Driver};SERVER="&servidor&";PORT=3306;DATABASE="&base&";USER="&login&";PWD="&senha&";OPTION=3;")

	Dim vUrl        : vUrl        = url
	Dim vProtegida  : vProtegida  = protegida
	Dim vData       : vData       = Right(("0" & day(date)),2)  & "/" & Right(("0" & month(date)),2)  & "/" & Right(("0" & year(date)),2)
	Dim vHora       : vHora       = Right(("0" & hour(time)),2) & ":" & Right(("0" & minute(time)),2) & ":" & Right(("0" & second(time)),2)
	Dim vDataHora   : vDataHora   = vData & " - " & vHora
	Dim vIp         : vIp         = Request.ServerVariables("REMOTE_ADDR")
	Dim vAddon      : vAddon      = addon
	Dim vAcao       : vAcao	      = acao

	Conn.Execute("INSERT INTO tbl_links(url,protegida,ip,addon,acao) VALUES('"&vUrl&"','"&vProtegida&"','"&vIp&"','"&vAddon&"','"&vAcao&"')")
	
	If acao = 1 Then
		Conn.Execute("UPDATE tbl_contador SET Hits = Hits + 1")
	End If

	Conn.Close
	Set Conn = Nothing

End Function
%>