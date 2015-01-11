<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

sql = ""
If Request("op") = "1" Then '// update

ElseIf Request("op") = "2" Then '// delete
  sql = "delete from sign_base where signid=" & Request("signid")
  Response.Write ExecQuery(sql)
  sql = "delete from sign_list where signid=" & Request("signid")
  Response.Write ExecQuery(sql)
End If



%>