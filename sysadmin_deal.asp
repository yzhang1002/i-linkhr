<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<!--#include file="func.asp"--> 

<%

sql = ""
If Request("op") = "0" Then '// insert
  sql = "insert into [admin]([admin],[password],[admin_right]) values ('" & formatSpString(Request("admin")) & "','" & md5(Request("password")) & "','" & formatSpString(Request("admin_right")) & "')"
ElseIf Request("op") = "1" Then '// update
  sql = "update [admin] set [admin]='" & formatSpString(Request("admin")) & "',[password]='" & md5(Request("password")) & "',[admin_right]='" & formatSpString(Request("admin_right")) & "' where [id]=" & Request("id")

ElseIf Request("op") = "2" Then '// delete
  sql = "delete from [admin] where [id]=" & Request("id")
End If

' Response.Write sql
Response.Write ExecQuery(sql)

%>