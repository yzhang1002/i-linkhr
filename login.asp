<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>I-LINKHR Management System</title>
<link href="images/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body{
  background:url(images/login_bg.jpg);
}

.inp {
	height:350px;
  width:729px;
  background:url(images/login_2.jpg) no-repeat;
}

.f-text {
  color: #568690;
  font-size:12pt;
  font-weight:bold;
  width:210px;
  height:25px;
  padding-top:2px;
  padding-left:5px;
  border:1px solid #ABC3C7;
  background:#E4F9FE;
}
-->
</style>
<script language=javascript>
<!--
function check()
{
  if(document.formLogin.name.value=="")
  {
    alert("The User Account is can not be empty.");
    document.formLogin.name.focus();
    return false;
  }
  if(document.formLogin.pass.value=="")
  {
    alert("The User Password is can not be empty.");
    document.formLogin.pass.focus();
    return false;
  }
}
-->
</script>

</head>

<body>
<TABLE width="100%" height="100%">
<TR>
  <TD valign="top" style="padding-top:100px;">
    <form method="post" style="margin:0px;" action="checkuser.asp"  onsubmit="return check()" name="formLogin">
    <table width=350 border=0 align=center cellspacing=0 class="inp">
      <tr height=22>
        <td>&nbsp;</td>
      </tr>
      
      <tr height=22>
        <td style="padding-left:180px">
        

          <table width="500" cellspacing=0 border=0 cellpading=0 style="font-size:9pt;">
          <tr>
            <td colspan="2" height="55"></td>
          </tr>
          <tr>
            <td width="100" align="right" style="color:#335765;font-size:10pt;padding-right:10px;">Username :&nbsp;</td>
            <td><input type="text" name="name" class="f-text"></td>
          </tr>
          <tr>
            <td colspan="2" height="20"></td>
          </tr>
          <tr>
            <td align="right" style="color:#335765;font-size:10pt;padding-right:10px;">User&nbsp;&nbsp; PIN :&nbsp;</td>
            <td><input type="password" name="pass" class="f-text"></td>
          </tr>
          <tr>
            <td colspan="2" height="20"></td>
          </tr>
          <tr>
            <td style="padding-left:220px" colspan=2>
            <input type="image" src="images/login_but.jpg">
            </td>
          </tr>
          <tr><td align=left colspan=2 style="height:30px;color:red;font-size:10pt;">&nbsp;<%=session("erro")%></td></tr>
          </table>


        
        </td>
      </tr>
      <tr height=22>
        <td>&nbsp;</td>
      </tr>

      </table>
    </form>


  </TD>
</TR>
</TABLE>


</body>
</html>