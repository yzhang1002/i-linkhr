<html>
<head>
<title>I-LINKHR Management System customer add</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<link rel="stylesheet" type="text/css" href="js/facebox/facebox.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script type="text/javascript" src="js/facebox/facebox.js"></script>
<script type="text/javascript" src="js/common.js"></script>


<script language=javascript>
var g_id = '<%=Request("cusid")%>';

$(document).ready(function(){
  if(g_id != "") {
    showHint("Data Loading...");
    $.ajax({ 
      url: "customer_detail.asp", 
      data: "cusid=" + g_id,
      type:"post",
      dataType: "json",
      cache:false,
      success: function(obj){
        setInputValue(obj.data,"base-form");
        $("#operation").html("Modify Customer Information");
        $("input[name='op']").val("1");
        hideHint();
      },
      error:function(XMLHttpRequest, textStatus, errorThrown){
        // alert(errorThrown);
        hideHint();
      }

    });
  }
  else
  {
    $("#operation").html("Add Customer Information");
    $("input[name='op']").val("0");
  }
});

function doSubmit()
{

  obj = $("input[name='cusname']")
  if($.trim(obj.val()) == "")
  {
    alert("Customer Name is can not be empty.");
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


  obj = $("input[name='accountno']")
  if($.trim(obj.val()) == "")
  {
    alert("Account No is can not be empty.");
    obj.focus();
    return;
  }


  obj = $("input[name='termpay']")
  if($.trim(obj.val()) == "")
  {
    alert("Terms of Payment is can not be empty.");
    obj.focus();
    return;
  }


  obj = $("input[name='hotelrate']")
  if( !$.isNumber(obj.val()) )
  {
    alert("Hotel rate is not a valid number.");
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
        location.href="customer.asp";
      }
      else
      {
        alert("Save failed.");
      }
      hideHint();
    }
  });


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
              <h2 id="operation">Customer Data</h2>
              <span class="sub_hint"></span>
            </div>
            <div class="sect">
          <form action="customer_deal.asp" method="post" id="base-form">

            <TABLE cellpadding="0" cellspacing="0">
              <TR height="40">
                <TD width="120px" align="right">Customer Name:</TD>
                <TD width="200px">&nbsp;<input type="text" class="f-input" name="cusname"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Hotel Rate:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="hotelrate"><label class="hint_red">*</label></TD>
              </TR>

              <TR height="40">
                <TD align="right">Customer Address:</TD>
                <TD colspan="4">&nbsp;<input style="width:440px;" type="text" class="f-input" name="address"><label class="hint_red">*</label></TD>
              </TR>
              <TR height="40">
                <TD align="right">Tel:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="tel"><label class="hint_red"></label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Fax:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="fax"><label class="hint_red"></label></TD>
              </TR>

              <TR height="40">
                <TD align="right">Account No:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="accountno"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">E-Mail:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="email"><label class="hint_red"></label></TD>
              </TR>
              <TR height="40">
                <TD align="right">Terms of Payment:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="termpay"><label class="hint_red">*</label></TD>
                <TD>&nbsp;&nbsp;</TD>
                <TD align="right">Registration No:</TD>
                <TD>&nbsp;<input type="text" class="f-input" name="cregno"><label class="hint_red"></label></TD>
              </TR>
              <TR height="40">
                <TD align="right">Attention:</TD>
                <TD colspan="4">&nbsp;<input style="width:440px;" type="text" class="f-input" name="attention"><label class="hint_red">*</label></TD>
              </TR>

              
              <TR height="40">
                <TD colspan="5" align="center"><input type="button" class="but2" id="signup-submit" name="commit" value="Save" onclick="doSubmit()">
                <input type="hidden" name="cusid" value="">
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