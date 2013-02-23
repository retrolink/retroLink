<!--#include file="inc/config.asp"-->
<%
Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.ConnectionString = "DRIVER={MySQL ODBC 3.51 Driver};SERVER="&servidor&";PORT=3306;DATABASE="&base&";USER="&login&";PWD="&senha&";OPTION=3;"
Conexao.Open

Set rsBusca = Server.CreateObject("ADODB.Recordset")
rsBusca.ActiveConnection = Conexao
rsBusca.CursorLocation = 3

If rsBusca.State = 1 Then rsBusca.Close
rsBusca.Open "SELECT * FROM tbl_links ORDER BY id DESC LIMIT 1, 100"

Dim vData : vData = Right(("0" & day(date)),2)  & "/" & Right(("0" & month(date)),2)  & "/" & Right(("0" & year(date)),2)
Dim vHora : vHora = Right(("0" & hour(time)),2) & ":" & Right(("0" & minute(time)),2) & ":" & Right(("0" & second(time)),2)

Response.Write "Hora Atual: " & vData & " - " & vHora & "<br />"

For i = 1 To rsBusca.RecordCount

	vUrl       = rsBusca("url")
	vProtegida = rsBusca("protegida")
	vAddon     = rsBusca("addon")
	vAcao      = rsBusca("acao")
	vData      = rsBusca("data")
	vIp        = rsBusca("ip")
	
	if vAcao = 1 then
		cor = "green"
	else
		cor = "red"
	end if
	
	linha = "----------------------------------------------------------------------------------------------------------------"

	Response.Write linha
	Response.Write "<br />"
	Response.Write "<font size=""2"" face=""arial"" color="""&cor&""">"
	Response.Write "URL Protegida: " & vProtegida & "<br />"
	Response.Write "URL Desprotegida: " & vUrl & "<br />"
	Response.Write "<font color=""#000000"">"&vData&" | "&vIp&" | "&vAddon&"</font><br />"
	Response.Write "</font>"
	
rsBusca.MoveNext : Next

Response.Write linha

rsBusca.Close
Set rsBusca = Nothing

Conexao.Close
Set Conexao = Nothing

%>