<%
Dim Base64Chars
Base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

Function mimedecode( byVal strIn )
	If Len( strIn ) = 0 Then 
		mimedecode = -1 : Exit Function
	Else
		mimedecode = InStr( Base64Chars, strIn ) - 1
	End If
End Function

Function base64_decode( byVal strIn )
	Dim w1, w2, w3, w4, n, strOut
	For n = 1 To Len( strIn ) Step 4
		w1 = mimedecode( Mid( strIn, n, 1 ) )
		w2 = mimedecode( Mid( strIn, n + 1, 1 ) )
		w3 = mimedecode( Mid( strIn, n + 2, 1 ) )
		w4 = mimedecode( Mid( strIn, n + 3, 1 ) )
		If w2 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w1 * 4 + Int( w2 / 16 ) ) And 255 ) )
		If w3 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w2 * 16 + Int( w3 / 4 ) ) And 255 ) )
		If w4 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w3 * 64 + w4 ) And 255 ) )
	Next
	base64_decode = strOut
End Function

function hexDecode(str)
	dim strDecoded, i, hexValue
	strDecoded = ""
	for i = 1 to Len(str)
		hexValue = ""
		hexValue = hexValue + Mid(str, i,2)
		i = i+1
		strDecoded = strDecoded + chr(CLng("&h" & hexValue))
	next
	hexDecode = strDecoded
end function
%>