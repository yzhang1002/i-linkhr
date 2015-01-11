<!--#include file="conn.asp"-->
<%
cusid=Request("cusid")

set rs = GetRecordSet("select * from customer where cusid=" & cusid)

Response.ContentType = "Content-Type:text/html; charset=utf-8"

Response.Write Rs2Json(rs)
%>