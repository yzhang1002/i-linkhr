<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<html>
<head>
<title>I-LINKHR Management System invoice hotel</title>
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
$(document).ready(function(){
});

function doQryCus()
{
  var cusname = $.trim($("input[name='cusname']").val());
  var accountno = $.trim($("input[name='accountno']").val());

  var where = "";
  if(cusname != "")
    where = "cusname='" + cusname + "'";
  
  if(ic != "" && where == "")
  {
    where = "accountno='" + accountno + "'";
  }
  else if(accountno != "" && where != "")
  {
    where = where + " and accountno='" + accountno + "'";
  }
  
  if(where == "")
  {
    return;
  }

  showHint("Data Loading...");

  $.ajax({ 
    url: "getCustom.asp", 
    data: "txtWhere=" + EncodeUtf8(where),
    type:"post",
    async:false,
    dataType: "text",
    success: function(msg){
      if(msg != "")
      {
          var o = document.all("hotelname");
          for(var k=0;k<o.options.length;k++)
          {
            if(o.options[k].value == msg)
            {
              o.selectedIndex = k;
              break;
            }
          }

      }
      else
      {
        alert("Query customer information failure.")
      }
      hideHint();
    }
  });


}

function doQueryInvoice()
{

  obj = $("select[name='hotelname']")
  if($.trim(obj.val()) == "")
  {
    alert("The Hotel is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='fdate']")
  if($.trim(obj.val()) == "")
  {
    alert("The from date is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='tdate']")
  if($.trim(obj.val()) == "")
  {
    alert("The To date is can not be empty.");
    obj.focus();
    return;
  }
  
  param = $("#query-form").serialize();
  showHint("Data Loading...");

  $.ajax({ 
    url: "invoice_no_list.asp", 
    data: param,
    type:"post",
    dataType: "text",
    success: function(msg){
      if(msg != "")
      {
        $("#dataList").html(msg);
      }
      else
      {
        $("#dataList").html("No Data.");
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
    <td style="padding-left:10px;">
    <TABLE width="100%" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Invoice for Hotel</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <form action="" style="margin:0px;" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right" width="100px">Customer Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="cusname" ignore="true"></TD>
              <TD width="80px" align="right">Account No:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="accountno" ignore="true"></TD>
              <TD width="40px"><img style="cursor:pointer;margin-top:5px;" onclick="doQryCus()" src="images/qry.jpg"></TD>
            </TR>
            <TR height="30">
              <TD align="right" style="padding-left:10px;"><B>Hotel:</B></TD>
              <TD>&nbsp;<select name="hotelname" style="width:155px">
          <option value="">--Please Select--</option>
        <%
        sql = "select cusname from customer order by cusname"
        set rs1 = GetRecordSet(sql)
        If (Not rs1.eof) And (Not rs1.bof) Then
          Do While (Not rs1.eof) And (Not rs1.bof) 
        %>
          <option value="<%=rs1("cusname")%>"><%=rs1("cusname")%></option>
        <%
            rs1.MoveNext
          Loop
        End If
        rs1.Close
        Set rs1 = Nothing

        %>
        </select><label class="hint_red">*</label>
              </TD>
            </TR>
            <TR height="30">
              <TD align="left" colspan="6" style="padding-left:20px;"><B>Working Date:</B></TD>
            </TR>
            <TR height="30">
              <TD align="right">Form:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="fdate" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              <TD align="right">To:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="tdate" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              <TD align="right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="but2" id="query" name="query" value="Query" onclick="doQueryInvoice()">
              &nbsp;&nbsp;&nbsp;
              </TD>
            </TR>

          </TABLE>
        </form>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;"></TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;" id="dataList">
      </TD>
    </TR>

    </TABLE>

    </td>
  </tr>
</table>



</body>
</html>