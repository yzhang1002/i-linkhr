<!--#include file="conn.asp"-->
<%
set rs = GetRecordSet("select hotelrate from customer where cusname='" & Request("cusname") & "'")

Response.ContentType = "Content-Type:text/html; charset=utf-8"


If (Not rs.eof) And (Not rs.bof) Then
  Response.Write rs("hotelrate")
Else
  Response.Write "0"
End If
%>