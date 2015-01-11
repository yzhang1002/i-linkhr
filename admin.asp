<!-- #include file="conn.asp" -->
<!-- #include file="cookies.asp" -->
<!--#include file="func.asp"--> 
<%
'增加一个管理员
  set rs2=server.createobject("adodb.recordset")
  sql2="select count(*) from admin where admin='"&request("name1")&"'"
  rs2.open sql2,conn,3,3
   if rs2(0)<>0 then
  response.redirect "error1.asp?err_on=6"
end if
 if request("types")="addname" then
 if request("name1")="" then
  response.redirect "error1.asp?err_on=7"
 elseif request("pass1")="" then
  response.redirect "error1.asp?err_on=8"
 else
  set rs1=server.createobject("adodb.recordset")
  sql1="select * from admin"
  rs1.open sql1,conn,3,3
  rs1.addnew
  rs1("admin")=md5(request("name1"))
  rs1("password")=md5(request("pass1"))
  rs1("admin_right")=request("admin_right")
  rs1.update
  rs1.close
  set rs1=nothing
 end if
end if
rs2.close
set rs2=nothing
%>
<%
'修改一个管理员
if request("types")="mod" then
  sql4="update admin set admin='"&request("name")&"' where id="&request("id")
  conn.execute(sql4)
  sql4="update admin set password='"&md5(request("pass"))&"' where id="&request("id")
  conn.execute(sql4)
end if
 if request("types")="del" then
 sql5="delete from admin where id="&request("id")
 conn.execute(sql5)
 end if
%>
<html>
<head>
<title>增加修改管理员</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.inp {
	background-color: #f7f7f7;
	border: 1px solid #999999;
	font-size: 12px;
	color: #333333;
}
.an {
	font-size: 14px;
}
-->
</style>

</head>

<body>
<% set rs=server.createobject("adodb.recordset") 
   sql="select count(*) from admin"
   rs.open sql,conn,3,3
   if rs(0)=0 then
   response.write "<center>对不起，还没有任何一个管理员，请新增一个管理员。"
   rs.close
   set rs=nothing
 %><div align="center">
<p><font face="楷体_GB2312" size="4" color="#999999">新增一个管理员</font></p>
  <form action="admin.asp" method=post>
    <table class="inp">
      <tr> 
        <td width="71">姓名：</td>
        <td width="155"> 
          <input type="text" name="name1">
       
      </td>
    </tr>
    <tr> 
        <td width="71">密码：</td>
        <td width="155"> 
          <input type="text" name="pass1">
      </td>
    </tr>
	<tr> 
        <td width="71">权限：</td>
        <td width="155"> 
         <select name="admin_right">
		 <option value="0">普通管理员</option>
		 <option value="1">超级管理员</option>
		 </select>
      </td>
    </tr>
  </table>
  <p>
    <input type="submit" name="addname" value="提交">
	<input type=hidden name="types" value="addname">
  </p>
   </form>
  <% else %>
    <div align="center">
  <p><font face="楷体_GB2312" size="4" color="#999999">新增一个管理员</font></p>
  <form action="admin.asp" method=post>
    <table class="inp">
      <tr> 
        <td width="71">姓名：</td>
        <td width="155"> 
          <input type="text" name="name1">
       
      </td>
    </tr>
    <tr> 
        <td width="71">密码：</td>
        <td width="155"> 
          <input type="text" name="pass1">
      </td>
    </tr>
	<tr> 
        <td width="71">权限：</td>
        <td width="155"> 
         <select name="admin_right">
		 <option value="0">普通管理员</option>
		 <option value="1">超级管理员</option>
		 </select>
      </td>
    </tr>
  </table>
  <p>
    <input type="submit" name="addname" value="提交">
	<input type=hidden name="types" value="addname">
  </p>
   </form>
   <% set rs3=server.createobject("adodb.recordset")
    sql3="select * from admin"
    rs3.open sql3,conn,3,3
  %>
 <%rs3.movefirst
   for i=1 to rs3.recordcount
  %>
  <div align="center">
 <form method=post action="admin.asp">
    <table class="inp">
      <tr>
        <td width="50"><%=trim(rs3("id"))%></td>
        <td width="140"> 
          <input type="text" name="name" value="<%=trim(rs3("admin"))%>" size="10">
        </td>
        <td width="140"> 
          <input type="text" name="pass" value="<%=trim(rs3("password"))%>" size="10">
        </td>

		  <td width="140"> 
         <% if trim(rs3("admin_right"))="1" then
		 %>
		 超级管理员
		 <%
		 else
		 %>
		 普通管理员
		 <%
		  end if
		 %>
        </td>

		<form method=post>
        <td width="59"> 
          <input type="submit" name="modify" value="修改">
		  <input type="hidden" name="id" value="<%=rs3("id")%>">
		  <input type="hidden" name="types" value="mod">
   </td>
   </form>
   <form method=post>
        <td width="57"> 
          <input type="submit" name="del" value="删除">
		  <input type="hidden" name="id" value="<%=rs3("id")%>">
		  <input type="hidden" name="types" value="del">
   </td>
   </form>
   </tr>
   </table>
   </form>
   </div>
 <%
 rs3.movenext
 next
 rs3.close
 set rs3=nothing
  end if
 conn.close
 set conn=nothing
%>
</body>
</html>
