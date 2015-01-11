<!--#include file="conn.asp"-->
<%
staffid=Request("staffid")

set rs = GetRecordSet("select * from staff where staffid=" & staffid)

Response.ContentType = "Content-Type:text/html; charset=utf-8"

Response.Write Rs2Json(rs)
%>