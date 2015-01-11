<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

sql = "update company set cname='" & formatSpString(Request("cname")) & "',address='" & formatSpString(Request("address")) & "',tel='" & formatSpString(Request("tel")) & "',fax='" & formatSpString(Request("fax")) & "',email='" & formatSpString(Request("email")) & "',regno='" & formatSpString(Request("regno")) & "',logo='" & formatSpString(Request("logo")) & "' where id=1"

Response.Write ExecQuery(sql)

%>