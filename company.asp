<html>
<head>
<title>I-LINKHR Management System Company</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<link rel="stylesheet" type="text/css" href="js/facebox/facebox.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script type="text/javascript" src="js/facebox/facebox.js"></script>
<script type="text/javascript" src="js/common.js"></script>


<script language=javascript>

$(document).ready(function(){
  showHint("Data Loading...");

  $.ajax({ 
    url: "company_detail.asp", 
    data: "",
    type:"post",
    dataType: "json",
    cache:false,
    success: function(obj){
      setInputValue(obj.data,"base-form");
      
      if(obj.data.logo != "")
      {
        document.getElementById("preview").src="upload/" + obj.data.logo;
      }

      hideHint();

    },
    error:function(XMLHttpRequest, textStatus, errorThrown){
      // alert(errorThrown);
    }

  });

});

function doSubmit()
{

  obj = $("input[name='cname']")
  if($.trim(obj.val()) == "")
  {
    alert("Company Name is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='address']")
  if($.trim(obj.val()) == "")
  {
    alert("Customer Address is can not be empty.");
    obj.focus();
    return;
  }


  obj = $("input[name='tel']")
  if($.trim(obj.val()) == "")
  {
    alert("Tel is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='fax']")
  if($.trim(obj.val()) == "")
  {
    alert("Fax is can not be empty.");
    obj.focus();
    return;
  }


  param = $("#base-form").serialize();
  url = $("#base-form").attr("action");
  showHint("Data Processing...");

  $.ajax({ 
    url: url, 
    data: param,
    type:"post",
    dataType: "text",
    success: function(msg){
      if(msg == "")
      {
        alert("Save successfully.");
        location.href="company.asp";
      }
      else
      {
        alert("Save failed.");
      }
      hideHint();
    }
  });


}


function UploadSaved(sFileName)
{
  $("input[name='logo']").val(sFileName) ;
  document.getElementById("preview").src="upload/" + sFileName;
}

function UploadError(sMsg)
{
  alert(sMsg);
}
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
              <h2 id="operation">Company Information</h2>
              <span class="sub_hint"></span>
            </div>
            <div class="sect">
          <form action="company_deal.asp" method="post" id="base-form">

            <TABLE cellpadding="0" cellspacing="0">
              <TR height="40">
                <TD width="120px" align="right">Company Name:</TD>
                <TD width="200px">&nbsp;<input type="text" class="f-input" name="cname" value="I-LINKHR Pte Ltd" readOnly="readOnly"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
              </TR>

              <TR height="40">
                <TD align="right">Address:</TD>
                <TD colspan="4">&nbsp;<input style="width:440px;" type="text" class="f-input" name="address"><label class="hint_red">*</label></TD>
              </TR>
              <TR height="40">
                <TD align="right">Tel:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="tel"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Fax:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="fax"><label class="hint_red">*</label></TD>
              </TR>

              <TR height="40">
                <TD align="right">E-Mail:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="email"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Registration No:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="regno"><label class="hint_red">*</label></TD>
              </TR>
              <TR>
                <TD align="right">&nbsp;</TD>
                <TD colspan="6" valign="bottom"><img style="border:1px solid #cccccc;" id="preview" src="images/nologo.jpg" width="375px" height="70px">
                </TD>
              </TR>

              <TR height="40">
                <TD align="right">Logo File:</TD>
                <TD colspan="5" valign="bottom"><iframe style="margin:0px;" id="d_file" frameborder=0 src="UploadPic.asp" width="600" height="30" scrolling=no></iframe>
                  <input type="hidden" name="logo">
                </TD>
              </TR>

              <TR height="40">
                <TD colspan="5" align="center"><input type="button" class="but2" id="signup-submit" name="commit" value="Save" onclick="doSubmit()">
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