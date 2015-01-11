<!--#include file="conn.asp"-->
<!--#include file="func.asp"--> 
 <%
dim name
dim pass1
dim pass2
name = Request("name")
pass1 = md5(Request("pass"))
' Response.Write pass1

sql="select * from [admin] where [admin]='"&name&"'"


set rs = GetRecordSet(sql)

if not rs.eof and not rs.bof then
  pass2=rs("password")
else 
  pass2="jwfakjfakjwakhfauwkjahsjahkj"
end If


if pass1=pass2  then
  session("admin")="pingfenxitongadmin"
  Session("UserName") = rs("admin")
  Session("right") = rs("admin_right")
%>
  <script language="javascript">
  window.open("manage.asp","_top")
  </script>
<%
else
  session("erro")= "User name or password is incorrect!"
  response.redirect "login.asp"
end if
rs.close
set rs=nothing
%>