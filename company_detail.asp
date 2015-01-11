<!--#include file="conn.asp"-->
<%

set rs = GetRecordSet("select * from company where id=1")

Response.ContentType = "Content-Type:text/html; charset=utf-8"

Response.Write Rs2Json(rs)
%>