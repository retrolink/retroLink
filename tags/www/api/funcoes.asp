<%
' ------------------------
' @ RemoveWhiteSpace(strText)
' Limpa a string retirando os espaços em vazio
' ------------------------
Function RemoveWhiteSpace(strText)
    Dim RegEx
    Set RegEx = New RegExp
    RegEx.Pattern = "\s+"
    RegEx.Multiline = false
    RegEx.Global = True
    strText = RegEx.Replace(strText," ")
    RemoveWhiteSpace = strText
End Function

' ------------------------
' @ redir_addon(add)
' Faz o redirecionamento diferenciando o método do fire em relação aos outros sistemas
' ------------------------
Function redir_addon(add)
	'if add = "firefox" then
		redir_addon = "window.location = ""http://retrolink.com.br"";"
	'else
		'redir_addon = "window.close();"
	'end if
End Function

' ------------------------
' @ pontinhos(palavra,numero)
' Adiciona três pontinhos a textos longos
' ------------------------
Function pontinhos(VarTexto, Max)
	if Int(Len(VarTexto)) > Max then
		pontinhos = Left(VarTexto, Max)&"..."
	else
		pontinhos = VarTexto
	end if
End Function

' ------------------------
' @ BinToText(varBinData, intDataSizeInBytes)
' Transforme binario para texto, utilizado quando uso xmlhttp, alguns sites retornam content binary, por isso devo usar esta function
' ------------------------
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

Function removeAllTags(ByVal strInputEntry)

	strInputEntry = Replace(strInputEntry, "<", "&lt;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, ">", "&gt;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "'", "&#039;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, """", "&quot;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "\", "&#092;", 1, -1, 1)

	removeAllTags = strInputEntry

End Function

Function URLDecode(sConvert)

    Dim aSplit
    Dim sOutput
    Dim I

    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If

    sOutput = REPLACE(sConvert, "+", " ")

    aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If

    URLDecode = sOutput

End Function
%>