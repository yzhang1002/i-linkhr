<!--#include file="conn.asp"-->
<%
set rs = GetRecordSet("select cusname from customer where " & Request("txtWhere"))

Response.ContentType = "Content-Type:text/html; charset=utf-8"


If (Not rs.eof) And (Not rs.bof) Then
  Response.Write rs("cusname")
End If
%>