<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

signid = Request("signid")

staffid = Request("staffid")

staffrate = Request("staffrate")

sql = "update sign_list set staffrate='" & formatSpString(staffrate) & "' where signid=" & signid & " and staffid=" & staffid

Response.Write ExecQuery(sql)
%>