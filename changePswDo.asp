<!--#include file="conn.asp"-->
<!--#include file="func.asp"--> 
<%

admin = Request("admin")

sql="select top 1 id from admin where admin='"&admin&"' and password='" & md5(Request("oldpassword")) & "'"

set rs = GetRecordSet(sql)

if not rs.eof and not rs.bof then
  sql="update admin set [password]='" & md5(Request("password")) & "' where [id]=" & rs("id")
  ' Response.Write sql

  Response.Write ExecQuery(sql)
else 
  Response.Write "Old password is incorrect."
end If

rs.close
set rs=nothing
%>