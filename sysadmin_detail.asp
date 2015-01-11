<!--#include file="conn.asp"-->
<%

set rs = GetRecordSet("select [id],[admin],[admin_right] from [admin] where [id]=" & Request("id"))

Response.ContentType = "Content-Type:text/html; charset=utf-8"

Response.Write Rs2Json(rs)
%>