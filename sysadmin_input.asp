<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<html>
<head>
<title>I-LINKHR Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<link rel="stylesheet" type="text/css" href="js/facebox/facebox.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script type="text/javascript" src="js/facebox/facebox.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>


<script language=javascript>
<!--
var g_id = '<%=Request("id")%>';

$(document).ready(function(){
  if(g_id != "") {
    showHint("Data Loading...");
    $.ajax({ 
      url: "sysadmin_detail.asp", 
      data: "id=" + g_id,
      type:"post",
      dataType: "json",
      cache:false,
      success: function(obj){
        setInputValue(obj.data,"base-form");

        $("#operation").html("Modify Admin Information");
        $("input[name='op']").val("1");

        if(obj.data.admin_right.indexOf("1") != -1)
          $("input[name='admin_right'][value='1']").attr("checked",true);
        if(obj.data.admin_right.indexOf("2") != -1)
          $("input[name='admin_right'][value='2']").attr("checked",true);
        if(obj.data.admin_right.indexOf("3") != -1)
          $("input[name='admin_right'][value='3']").attr("checked",true);
        if(obj.data.admin_right.indexOf("4") != -1)
          $("input[name='admin_right'][value='4']").attr("checked",true);

        hideHint();

      },
      error:function(XMLHttpRequest, textStatus, errorThrown){
        hideHint();
      }

    });
  }
  else
  {
    $("#operation").html("Add New Admin Information");
    $("input[name='op']").val("0");
  }
});

function doSubmit()
{
  obj = $("input[name='admin']")
  if($.trim(obj.val()) == "")
  {
    alert("The User Name is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='password']")
  if($.trim(obj.val()) == "")
  {
    alert("The password is can not be empty.");
    obj.focus();
    return;
  }
  

  obj = $("input[name='re-password']")
  if($.trim(obj.val()) != $.trim($("input[name='password']").val()))
  {
    alert("Not the same as the password twice.");
    obj.focus();
    return;
  }


  obj = $("input[name='admin_right']:checked");
  if(obj.length == 0)
  {
    alert("The user right is can not be empty.");
    return "";
  }

  showHint("Data Processing...");

  param = $("#base-form").serialize();
  url = $("#base-form").attr("action");
  
  $.ajax({ 
    url: url, 
    data: param,
    type:"post",
    dataType: "text",
    success: function(msg){
      if(msg == "")
      {
        alert("Save successfully.");
        location.href="sysadmin.asp";
      }
      else
      {
        alert("Save failed.");
      }
      hideHint();
    }
  });

}

-->
</script>

</head>
<body>


<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td>

    <div id="content">
      <div id="deal-stuff" class="cf">
        <div class="box">
          <div class="box-top"></div>
          <div class="box-content cf">
            <div class="head">
              <h2 id="operation">System Admin Data</h2>
              <span class="sub_hint"></span>
            </div>
            <div class="sect">
          <form action="sysadmin_deal.asp" method="post" id="base-form">

            <TABLE cellpadding="0" cellspacing="0">
              <TR height="40">
                <TD width="100px" align="right">User Name:</TD>
                <TD width="200px">&nbsp;<input type="text" style="width:145px;" class="f-input" name="admin"><label class="hint_red">*</label></TD>
                </TD>
              </TR>

              <TR height="40">
                <TD align="right">Password:</TD>
                <TD>&nbsp;<input type="password" class="f-input" name="password"><label class="hint_red">*</label></TD>
              </TR>

              <TR height="40">
                <TD align="right">Confirm Password:</TD>
                <TD>&nbsp;<input type="password" class="f-input" name="re-password"><label class="hint_red">*</label></TD>
              </TR>

              <TR height="40">
                <TD align="right">User Right List:</TD>
                <TD>&nbsp;<input type="checkbox" name="admin_right" value="1"> System administrator&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="admin_right" value="2"> Basic information &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="admin_right" value="3"> Operation Department &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="admin_right" value="4"> Finance Department &nbsp;&nbsp;&nbsp;&nbsp;
                </TD>
              </TR>
              <TR height="40">
                <TD colspan="5" align="center">
                <input type="button" class="but2" id="signup-submit" name="commit" value="Save" onclick="doSubmit()">
                <input type="hidden" name="id" value="">
                <input type="hidden" name="op" value="0">
                </TD>
              </TR>
            </TABLE>

        </form>
                </div>
            </div>
            <div class="box-bottom"></div>
          </div>
        </div>
      </div>

    </td>
  </tr>
</table>

</body>
</html>