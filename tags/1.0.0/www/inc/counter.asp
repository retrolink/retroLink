<!--#include file="config.asp"-->
<%
Function Contador()
	
	Set Conn = Server.CreateObject("ADODB.Connection")
	
	Conn.Open("DRIVER={MySQL ODBC 3.51 Driver};SERVER="&servidor&";PORT=3306;DATABASE="&base&";USER="&login&";PWD="&senha&";OPTION=3;")

	Set Counter = Conn.Execute("SELECT hits FROM tbl_contador")

	contador = FormatNumber(Counter("hits"),0)
	
	Response.Write contador

	Conn.Close
	Set Conn = Nothing

End Function

call Contador()
%>