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
<%
strWhere = Request("txtWhere")
strWhere = Server.URLEncode(strWhere)
%>

<script language=javascript>
<!--
var g_id = '<%=Request("staffid")%>';

$(document).ready(function(){
  if(g_id != "") {
    showHint("Data Loading...");
    $.ajax({ 
      url: "staff_detail.asp", 
      data: "staffid=" + g_id,
      type:"post",
      dataType: "json",
      cache:false,
      success: function(obj){
        setInputValue(obj.data,"base-form");

        $("input[name='birthday']").val(formatStr2EnDate(obj.data.birthday));
		    $("input[name='join_date']").val(formatStr2EnDate(obj.data.join_date));

        $("#operation").html("Modify Staff Information");
        $("input[name='op']").val("1");
        if(obj.data.photo != "")
        {
          document.getElementById("preview").src="upload/" + obj.data.photo;
        }
        hideHint();

      },
      error:function(XMLHttpRequest, textStatus, errorThrown){
        hideHint();
      }

    });
  }
  else
  {
    $("#operation").html("Add New Staff Information");
    $("input[name='op']").val("0");
  }
});

function UploadSaved(sFileName)
{
  $("input[name='photo']").val(sFileName) ;
  document.getElementById("preview").src="upload/" + sFileName;
}

function UploadError(sMsg)
{
  alert(sMsg);
}

function doSubmit()
{
  obj = $("input[name='name']")
  if($.trim(obj.val()) == "")
  {
    alert("The Name is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='ic']")
  if($.trim(obj.val()) == "")
  {
    alert("The IC is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='passport']")
  if($.trim(obj.val()) == "")
  {
    alert("The Passport No is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='birthday']")
  if($.trim(obj.val()) == "")
  {
    alert("Date of Birth is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='hpno']")
  if($.trim(obj.val()) == "")
  {
    alert("HP NO is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='birthday']");

  obj.val(formatDate2Str(obj.val()));
  
  obj = $("input[name='join_date']");

  obj.val(formatDate2Str(obj.val()));

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
        location.href="staff.asp?page=<%=Request("page")%>&txtwhere=<%=strWhere%>";
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
              <h2 id="operation">Staff Data</h2>
              <span class="sub_hint"></span>
            </div>
            <div class="sect">
          <form action="staff_deal.asp" method="post" id="base-form">

            <TABLE cellpadding="0" cellspacing="0">
              <TR height="40">
                <TD width="80px" align="right">Name:</TD>
                <TD width="200px">&nbsp;<input type="text" class="f-input" name="name"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Gender:</TD>
                <TD>&nbsp;<label for="gender1"><INPUT type="radio" id="gender1" name="gender" checked="checked" value="M">Male</label>
                  <label for="gender2"><INPUT type="radio" id="gender2" name="gender" value="F">Female</label><label class="hint_red">*</label>
                </TD>
              </TR>

              <TR height="40">
                <TD align="right">IC:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="ic"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Passport No:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="passport"><label class="hint_red">*</label></TD>
              </TR>
              <TR height="40">
                <TD align="right">Date of Birth:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="birthday" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Place of Birth:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="birthplace"></TD>
              </TR>
			  <TR height="40">
                <TD align="right">Join Date:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="join_date" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              </TR>

              <TR>
                <TD align="right">&nbsp;</TD>
                <TD colspan="6" valign="bottom"><img style="border:1px solid #cccccc;" id="preview" src="images/preview.jpg" width="500px" height="333">
                </TD>
              </TR>

              <TR height="40">
                <TD align="right">Photo File:</TD>
                <TD colspan="5" valign="bottom"><iframe style="margin:0px;" id="d_file" frameborder=0 src="UploadPic.asp" width="600" height="30" scrolling=no></iframe>
                  <input type="hidden" name="photo">
                </TD>
              </TR>

              <TR height="40">
                <TD align="right">Address:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="address"></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Post Code:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="postcode"></TD>
              </TR>
              <TR height="40">
                <TD align="right">HP NO:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="hpno"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Home NO:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="homeno"></TD>
              </TR>
              <TR height="40">
                <TD align="right">E-Mail:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="email"></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Bank Acc:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="bankacc"></TD>
              </TR>
              <TR height="40">
                <TD align="right">Nationality:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="nationality"></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">School:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="school"></TD>
              </TR>
              <TR height="40">
                <TD align="right">Main Hotel:</TD>
                <TD colspan="4">&nbsp;
                <select name="mainhotel">
                  <option value="">--Please Select--</option>
                <%
                sql = "select cusname from customer order by cusname"
                set rs = GetRecordSet(sql)
                If (Not rs.eof) And (Not rs.bof) Then
                  Do While (Not rs.eof) And (Not rs.bof) 
                %>
                                  <option value="<%=rs("cusname")%>"><%=rs("cusname")%></option>
                <%
                    rs.MoveNext
                  Loop
                End If
                rs.Close
                Set rs = Nothing
                %>
                </select>
                </TD>
              </TR>
              <TR height="40">
                <TD colspan="5" align="center">
                <input type="button" class="but2" id="signup-submit" name="commit" value="Save" onclick="doSubmit()">
                <input type="hidden" name="staffid" value="">
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