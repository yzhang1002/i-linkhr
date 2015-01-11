<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<html>
<head>
<title>I-LINKHR Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<script src="js/external/jquery/jquery.js"></script>
<script src="js/jquery-ui.js"></script>

<script language=javascript>
<!--
$(document).ready(function(){
  // getDataList();
var availableTags=[];
$("#staffid option").each(function()
{
    availableTags.push($(this).text());
});


  $( "#autocomplete" ).autocomplete({
    source: availableTags
  });
});

function doQryStaff()
{
  var name = $.trim($("input[name='name']").val());
  var ic = $.trim($("input[name='ic']").val());

  var where = "";
  if(name != "")
    where = "name='" + name + "'";
  
  if(ic != "" && where == "")
  {
    where = "ic='" + ic + "'";
  }
  else if(ic != "" && where != "")
  {
    where = where + " and ic='" + ic + "'";
  }
  
  if(where == "")
  {
    return;
  }

  $.ajax({ 
    url: "getStaff.asp", 
    data: "txtWhere=" + EncodeUtf8(where),
    type:"post",
    async:false,
    dataType: "text",
    success: function(msg){
      if(msg != "")
      {
          var o = document.all("staffid");
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
        alert("Query employee information failure.")
      }
    }
  });


}

function doQueryPayment()
{

  if($("#autocomplete").val()!=""){
    var staffidval = $('#staffid option').filter(function () { return $(this).html() == $("#autocomplete").val(); }).val();
    if(!staffidval){
      alert("Please check the staff name!");
      $("#staffid").val('');
    }
    else{
      $("#staffid").val(staffidval);
    }
  }

  obj = $("select[name='staffid']")
  if($.trim(obj.val()) == "")
  {
    alert("The Staff is can not be empty.");
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

  $("#query-form").submit();

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
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Payment for staff</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <form action="PaymentVoucher.asp" style="margin:0px;" target="_blank" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right" width="40px">Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" id="autocomplete" name="name"></TD>
              <TD width="40px" align="right">IC:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="ic"></TD>
              <TD width="40px"><img style="cursor:pointer;margin-top:5px;" onclick="doQryStaff()" src="images/qry.jpg"></TD>
            </TR>
            <TR height="30">
              <TD align="left" style="padding-left:10px;"><B>Staff:</B></TD>
              <TD>&nbsp;        <select name="staffid" id="staffid" style="width:155px">
          <option value="">--Please Select--</option>
        <%
        sql = "select staffid,name from staff order by name"
        set rs1 = GetRecordSet(sql)
        If (Not rs1.eof) And (Not rs1.bof) Then
          Do While (Not rs1.eof) And (Not rs1.bof) 
        %>
          <option value="<%=rs1("staffid")%>"><%=rs1("name")%></option>
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
              <TD align="left" colspan="6" style="padding-left:10px;"><B>Working Date:</B></TD>
            </TR>
            <TR height="30">
              <TD align="right">Form:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="fdate" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              <TD align="right">To:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="tdate" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
            </TR>
            <TR height="30">
              <TD align="right">Remark:</TD>
              <TD colspan="4">&nbsp;<TEXTAREA name="remark" class="f-textarea" style="width:375px;height:40px;"></TEXTAREA>
              </TD>
            </TR>

            <TR height="30">
              <TD colspan="4" align="right">&nbsp;<input type="button" class="but2" id="query" name="query" value="Query" onclick="doQueryPayment()">
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

    </TABLE>

    </td>
  </tr>
</table>



</body>
</html>