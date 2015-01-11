<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%

sql = ""
sig = Split(Request("signid"),",")
sta = Split(Request("staffid"),",")

For i=LBound(sig) To UBound(sig)
  sql = "update sign_list set paid='1' where signid=" & sig(i) & " and staffid=" & sta(i)
  ' Response.Write sql
  Response.Write ExecQuery(sql)
Next


%>