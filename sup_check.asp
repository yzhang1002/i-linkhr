<!--#include file="conn.asp"-->
<!--#include file="func.asp"--> 
 <%
  dim name
  dim pass1
  dim pass2
   name=request.form("name")
   pass1=md5(request.form("pass"))
 set rs=server.createobject("adodb.recordset")
 sql="select * from admin where admin_right=1 and admin='"&name&"'" 
 rs.open sql,conn,3,3
if not rs.eof and not rs.bof then
  pass2=rs("password")
else pass2=jwfakjfakjwakhfauwkjahsjahkj
end if
if pass1=pass2  then
 session("sup_name")="sup_login_succ"
 response.redirect "ADMIN.ASP"
else
 session("erro")= "用户名或密码错误！"
 response.redirect "sup_login.ASP"
end if
 rs.close
  set rs=nothing
  conn.close
  set conn=nothing
%>