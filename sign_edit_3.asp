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
<script type="text/javascript" src="js/jquery.qtip-1.0.0.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<script language=javascript>
<!--
$(document).ready(function(){

  $("select[name='hotelname']").bind("change",function(){
    if($(this).val() != "")
    {
      $.ajax({ 
        url: "hotelrate.asp", 
        data: "cusname=" + EncodeUtf8($(this).val()),
        type:"post",
        async:false,
        dataType: "text",
        success: function(msg){
          if(msg != "")
          {
            $("input[name='hotelrate']").val(parseFloat(msg));
          }
          else
          {
            $("input[name='hotelrate']").val("0");
          }
        }
      });

    }
  });

  var o = document.getElementById("hotelname");
  sValue = o.getAttribute("code");
  for(var k=0;k<o.options.length;k++)
  {
    if(o.options[k].value == sValue)
    {
      o.selectedIndex = k;
      break;
    }
  }

  $("input[name='staff_timein']").bind("blur",function(){
    reCalRow($(this).parent().parent())
  });

  $("input[name='staff_timeout']").bind("blur",function(){
    reCalRow($(this).parent().parent())
  });

  $("input[name='staff_hotelrate']").bind("blur",function(){
    reCalRow($(this).parent().parent())
  });

  $("input[name='break']").bind("blur",function(){
    reCalRow($(this).parent().parent())
  });
  


  $("input[name='amount']").bind("blur",function(){
    doCalTotal();
  });

  

  doCalTotal();

});


function reCalRow(n)
{
  var sDay = formatDate2Str($("input[name='signdate']").val());
  var timein = $(n).find("input[name='staff_timein']").val();
  var timeout = $(n).find("input[name='staff_timeout']").val();

  var hours = getSignHours(sDay,timein,timeout);
  $(n).find("[name='hours']").val(hours);
  $(n).find("[name='row_timein']").val(g_time_in);
  $(n).find("[name='row_timeout']").val(g_time_out);
  var breakhours = parseFloat($(n).find("[name='break']").val());
  $(n).find("[name='amount']").val( formatMoney((hours-breakhours) * $(n).find("[name='staff_hotelrate']").val()));

  doCalTotal();
}

function doDelete(sID)
{
  $("tr[staffid='"+sID+"']").remove();
  var idBox = $("tr[staffid]");
  $.each( idBox, function(i, n){
    $(n).find("td:first").text(i+1);
  });
}


function doCalTotal()
{
  hours = 0;
  var idBox = $("tr[staffid]");
  $.each( idBox, function(i, n){
    try
    {
      hours += parseFloat($(n).find("[name='hours']").val());
    }
    catch (e)
    {
    }
  });
  
  $("#totalhours").text(hours);

  amount = 0;
  $.each( idBox, function(i, n){
    try
    {
      amount += parseFloat($(n).find("[name='amount']").val());
    }
    catch (e)
    {
    }
  });
  
  $("#totalamount").text(amount);

}

function keyStaffRate(obj)
{
  var no = parseInt($("tr[staffid='"+obj.getAttribute("staffid")+"']").find("td:first").text());
  
  if(event.keyCode == 40 || event.keyCode == 13)
  {
    $("tr[staffid]:eq("+no+")").find("[name='staffrate']").focus();
  }
  else if(event.keyCode == 38)
  {
    $("tr[staffid]:eq("+(no-2)+")").find("[name='staffrate']").focus();
  }

}


function doSave()
{
  var error = false;
  var idBox = $("input[name='staff_timein']");

  if(idBox.length == 0)
  {
    alert("No staff.");
    return false;
  }
  else
    $("input[name='staffnum']").val(idBox.length);

  $.each( idBox, function(i, n){
    if(!checkTime($.trim($(n).val())))
    {
      alert("The Time in is invalid.");
      $(n).focus();
      error = true;
      return false;
    }
  });
  
  if(!error) {
    var idBox = $("input[name='staff_timeout']");
    $.each( idBox, function(i, n){
      if(!checkTime($.trim($(n).val())))
      {
        alert("The Time out is invalid.");
        $(n).focus();
        error = true;
        return false;
      }
    });
  }

  if(!error) {
    var idBox = $("input[name='staff_hotelrate']");
    $.each( idBox, function(i, n){
      if( !$.isNumber($(n).val()) )
      {
        alert("Hotel rate is not a valid number.");
        $(n).focus();
        error = true;
        return false;
      }
    });
  }

  if(!error) {
    var idBox = $("input[name='staffrate']");
    $.each( idBox, function(i, n){
      if( !$.isNumber($(n).val()) || parseFloat($(n).val()) <= 0 )
      {
        alert("Staff rate is not a valid number.");
        $(n).focus();
        error = true;
        return false;
      }
    });
  }

  if(!error) {
    var idBox = $("input[name='amount']");
    $.each( idBox, function(i, n){
      if( !$.isNumber($(n).val()) || parseFloat($(n).val()) <= 0 )
      {
        alert("Amount SGD is not a valid number.");
        $(n).focus();
        error = true;
        return false;
      }
    });
  }



  if(!error) {

    showHint("Data Processing...");

    var obj = $("input[name='signdate']");
    var signdate = obj.val();
    obj.val(formatDate2Str(obj.val()));

    var obj1 = $("input[name='billingdate']");
    var billingdate = obj1.val();
    obj1.val(formatDate2Str(obj1.val()));

    param = $("#base-form").serialize();
    obj.val(signdate);
    obj1.val(billingdate);
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
          window.location.reload();
		  //location.href="invoice_hotel.asp";
        }
        else
        {
          alert("Save failed.");
        }
        hideHint();
      }
    });


  }

}
-->
</script>

</head>
<body>
<%
signid = Request("signid")
staffid = Request("staffid")
sql = "select * from sign_base where signid=" & signid
set rs = GetRecordSet(sql)
chequeinfo = formatSpChar2Nor(rs("chequeinfo"))
chequeinfo = Replace(chequeinfo,"<br>",Chr(10))
%>
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <form style="margin:0px;" action="sign_edit_3_save.asp" method="post" id="base-form">
    <TABLE width="100%" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Make Sign
      <label id="hint" class="hint_red" style="font-size:9pt;font-weight:normal;padding-left:450px;">&nbsp;</label>
      </TD>
    </TR>
    <TR>
      <TD style="padding-bottom:10px;padding-top:10px;">
        
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right">WorKingDate:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="signdate" value="<%=formatDate2En(rs("signdate"))%>" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD width="120px" align="right">Job Order:</TD>
              <TD width="200px">&nbsp;<input type="text" class="f-input" name="joborder" value="<%=formatSpChar2Nor(rs("joborder"))%>"><label class="hint_red">*</label></TD>
            </TR>
            <TR height="30">
              <TD align="right">Time in:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="timein" value="<%=rs("timein")%>"><label class="hint_red">*</label></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Time out:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="timeout" value="<%=rs("timeout")%>"><label class="hint_red">*</label></TD>
            </TR>

            <TR height="30">
              <TD align="right">Hotel Name:</TD>
              <TD>&nbsp;
        <select name="hotelname" id="hotelname" style="width:155px" code="<%=rs("hotelname")%>">
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
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Hotel rate:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="hotelrate" value="<%=rs("hotelrate")%>"></TD>
            </TR>
            <TR height="30">
              <TD align="right">Venue Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="venuename" value="<%=formatSpChar2Nor(rs("venuename"))%>"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Attention:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="attention" value="<%=formatSpChar2Nor(rs("attention"))%>"></TD>
              <TD align="left">
              <input type="hidden" name="staffnum" value="">
              <input type="hidden" name="signid" value="<%=signid%>">

              </TD>
            </TR>

          </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;"></TD>
    </TR>

    <TR>
      <TD style="padding-top:10px;" id="dataList">
        <TABLE cellpadding="0" cellspacing="0" width="680">
          <TR height="30">
            <TD width="30"></TD>
            <TD align="right">BillingDate: <input type="text" class="f-input" name="billingdate" value="<%=formatDate2En(rs("billingdate"))%>" onfocus="return SelectDate(this,'dd/MM/yyyy')"></TD>
          </TR>
        </TABLE>
        <TABLE class="sList" cellpadding="0" cellspacing="0" id="staffList">
          <TR class="title" height="30">
            <TD width="30">No.</TD>
            <TD width="110">Staff Name</TD>
            <TD width="160">Identification No</TD>
            <TD width="50">Time in</TD>
            <TD width="60">Time out</TD>
            <TD width="40">Hours</TD>
            <TD width="40">Break</TD>
            <TD width="75">Hotel Rate</TD>
            <TD width="70">Staff Rate</TD>
            <TD width="90">Amount SGD</TD>
          </TR>

        <%
        rs.Close
        Set rs = Nothing


        sql = "select a.*,b.name,b.ic from sign_list a,staff b where a.staffid = b.staffid and a.signid=" & signid & " and b.staffid=" & staffid & " order by b.name"
        set rs = GetRecordSet(sql)
        i = 0
        If (Not rs.eof) And (Not rs.bof) Then
          Do While (Not rs.eof) And (Not rs.bof) 
            i=i+1
        %>
          <TR staffid="<%=rs("staffid")%>" class="tdList" height="30">
            <TD style="text-align:center"><%=i%></TD>
            <TD><%=rs("name")%></TD>
            <TD><%=rs("ic")%></TD>
            <TD style="text-align:center"><input type="text" value="<%=formatDate2Time(rs("timein"))%>" name="staff_timein" style="width:40px;"></TD>
            <TD style="text-align:center"><input type="text" name="staff_timeout" value="<%=formatDate2Time(rs("timeout"))%>" style="width:40px;"></TD>
            <TD style="text-align:center"><input name="hours" type="text" value="<%=formatMoney(rs("hours"))%>" onkeydown="return false;" readOnly="readOnly" style="width:40px;"></TD>
            <TD style="text-align:center"><input name="break" type="text" value="<%=formatMoney(rs("break"))%>" style="width:40px;"></TD>
            <TD style="text-align:center"><input type="text" value="<%=formatMoney(rs("hotelrate"))%>" style="width:40px;" name="staff_hotelrate"></TD>
            <TD style="text-align:center"><input type="text" value="<%=formatMoney(rs("staffrate"))%>" onfocus="this.select()" staffid="<%=rs("staffid")%>" style="width:40px;" onkeydown="keyStaffRate(this)" name="staffrate"></TD>
            <TD style="text-align:center"><input type="text" value="<%=formatMoney(rs("amount"))%>" style="width:70px;" name="amount">
            <input type="hidden" name="staffid" value="<%=rs("staffid")%>"><input type="hidden" name="row_timein" value="<%=rs("timein")%>"><input type="hidden" name="row_timeout" value="<%=rs("timeout")%>">
            </TD>
          </TR>
        <%
            rs.MoveNext
          Loop
        End If
        rs.Close
        Set rs = Nothing
        %>
        </TABLE>

      </TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;" style="padding-left:430px;" id="totalhours">
        0
      </TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;">
        <TABLE>
        <TR>
          <TD style="padding-left:430px;font-size:12pt;font-weight:bold;">Total:</TD>
          <TD style="padding-left:200px;font-size:12pt;font-weight:bold;" id="totalamount">$0</TD>
        </TR>


        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="padding-left:95px;font-size:12pt;font-weight:bold;">
      <TEXTAREA name="chequeinfo" style="width:640px;height:40px;"><%=chequeinfo%></TEXTAREA>
      </TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;" style="padding-left:630px;">
        <input type="button" value="Save" class="but2" onclick="doSave()">
      </TD>
    </TR>
  </TABLE>

  </form>

    </td>
  </tr>
</table>


</body>
</html>