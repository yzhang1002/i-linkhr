<html>
<head>
<title>��̨�����½</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style/admin.css" type="text/css">
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
<script language=javascript>
<!--
function check()
{
if(document.form1.name.value=="")
 {alert("�ʺŲ���Ϊ��Ŷ��");return false}
if(document.form1.pass.value=="")
 {alert("���벻��Ϊ��Ŷ��");return false}


   
}
-->
</script>

</head>

<body>
<div align="center">
  <p><font size="5" color="#999999"><b>�༭��̨����Ա</b></font></p>
  <form name="form1" method="post" action="sup_check.asp" onsubmit="return check()">

<table class=inp width=350 cellspacing=0 border=0 align=center>
<tr height=22><td background="images\admin_user_admin.gif" width="15%"></td><td width=85% background="images\bg1.gif">
<font size=2>��������Ա��¼</font>
</td></tr>
<tr>
<td colspan=2 align=center height=200>
<table width=300 cellspacing=0 border=0 cellpading=0 style="font-size:9pt;">
<tr><td width=40>�ʺ�:</td><td width=60><input type="text" name="name" size="15" value=""></td></tr>
<tr><td>����:</td><td><input type="password" name="pass" size="15"></td></tr>
<tr><td align=center colspan=2 height=20></td></tr>
<tr><td align=right><input type="submit" name="Submit" value="��½"></td><td align=center><input type="reset" name="reset" value="ȡ��"></td></tr>
<tr><td align=center colspan=2>&nbsp;</td></tr>
<tr><td align=center colspan=2></td></tr>
</table>
</td>
</tr>
</table></form>
</div>
<div align="center"><font size=2 color=red><%=session("erro")%></font></div>

</body>
</html>