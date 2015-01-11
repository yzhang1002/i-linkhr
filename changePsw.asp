<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<html>
<head>
<title>I-LINKHR Management System change password.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<script language=javascript>
<!--
$(document).ready(function(){
});

function doSubmit()
{

  obj = $("input[name='oldpassword']")
  if($.trim(obj.val()) == "")
  {
    alert("The old password is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='password']")
  if($.trim(obj.val()) == "")
  {
    alert("The new password is can not be empty.");
    obj.focus();
    return;
  }

  if(obj.val() != $("input[name='cfpassword']").val())
  {
    alert("Not the same as the password twice.");
    $("input[name='cfpassword']").focus();
    return;
  }

  
  param = $("#query-form").serialize();

  $.ajax({ 
    url: "changePswDo.asp", 
    data: param,
    type:"post",
    dataType: "text",
    success: function(msg){
      if(msg != "")
      {
        alert(msg);
      }
      else
      {
        alert("Change Password Success.");
        location.href="Admin_right.asp";
      }
    }
  });


}
-->
</script>

</head>
<body>
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <TABLE width="100%" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">User change password.</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <form action="" style="margin:0px;" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right" width="100px">User Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" style="width:145px;background:#F0F0F0;" name="admin" readOnly="readOnly" value="<%=Session("UserName")%>"></TD>
            </TR>
            <TR height="30">
              <TD align="right" width="100px">Old Password:</TD>
              <TD>&nbsp;<input type="password" class="f-input" name="oldpassword" value=""></TD>
            </TR>
            <TR height="30">
              <TD align="right" width="100px">New Password:</TD>
              <TD>&nbsp;<input type="password" class="f-input" name="password" value=""></TD>
            </TR>

            <TR height="30">
              <TD align="right" width="100px">Comfirm Password:</TD>
              <TD>&nbsp;<input type="password" class="f-input" name="cfpassword" value=""></TD>
            </TR>
              <TR height="40">
                <TD colspan="5" align="right"><input type="button" class="but2" id="signup-submit" name="commit" value="Submit" onclick="doSubmit()">
                </TD>
              </TR>

          </TABLE>
        </form>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;"></TD>
    </TR>

    </TABLE>

    </td>
  </tr>
</table>



</body>
</html>