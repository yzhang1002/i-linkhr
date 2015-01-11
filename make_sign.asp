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
var g_html = "";
$(document).ready(function(){
  g_html = $("#winDiv").html();
  $("#winDiv").html("");
  // 提示层
  $("input[name='addstaff']").qtip(
  {
     content: {
        text: g_html,
        title: {
           text: "Please check you want to add staff",
           button: 'Close'
        }
     },
     position: {
       target: $(document.body), // Position it via the document body...
       corner: 'center' // ...at the center of the viewport
     },
     show: { 
        when: 'click', 
        solo: true // Only show one tooltip at a time
     },
     hide: false,
     style: {
        tip: true, // Apply a speech bubble tip to the tooltip at the designated tooltip corner
        border: {
           width: 9,
           radius: 4,
           color: '#666666'
        },
        name: 'light', // Use the default light style
        width: 720 // Set the tooltip width
     },
     api: {
       beforeShow: function()
       {
          $('#qtip-blanket').fadeIn(this.options.show.effect.length);
       },
       beforeHide: function()
       {
          $('#qtip-blanket').fadeOut(this.options.hide.effect.length);
          try{CloseTip();}catch(e){};
       }
    }

  });

  // 遮罩层
  $('<div id="qtip-blanket">')
  .css({
     position: 'absolute',
     top: $(document).scrollTop(), 
     left: 0,
     height: $(document).height(), 
     width: '100%',

     opacity: 0.7,
     backgroundColor: 'black',
     zIndex: 5000  
  })
  .appendTo(document.body)
  .hide();

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

});

function checkBaseData()
{
  obj = $("input[name='signdate']")
  if($.trim(obj.val()) == "")
  {
    alert("The Date is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='joborder']")
  if($.trim(obj.val()) == "")
  {
    alert("The Job Order is can not be empty.");
    obj.focus();
    return;
  }

  obj = $("input[name='timein']")
  if(!checkTime($.trim(obj.val())))
  {
    alert("The Time in is invalid.");
    obj.focus();
    return;
  }

  obj = $("input[name='timeout']")
  if(!checkTime($.trim(obj.val())))
  {
    alert("The Time out is invalid.");
    obj.focus();
    return;
  }

  obj = $("select[name='hotelname']")
  if($.trim(obj.val()) == "")
  {
    alert("The Hotel Name is can not be empty.");
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

  $("input[name='addstaff']").click();
}

function doDelete(sID)
{
  $("tr[staffid='"+sID+"']").remove();
  g_staff_num--;
  var idBox = $("tr[staffid]");
  $.each( idBox, function(i, n){
    $(n).find("td:first").text(i+1);
  });
}

function selectAll_S(obj)
{
   $("input[name='wait_staffid']").attr("checked",obj.checked);
}

g_staff_num = 0;
function addToList()
{
  var idBox = $("input[name='wait_staffid']:checked");
  if(idBox.length == 0)
  {
    alert("No select staff.");
    return "";
  }
  var sDay = formatDate2Str($("input[name='signdate']").val());
  var timein = $("input[name='timein']").val();
  var timeout = $("input[name='timeout']").val();
  var hotelrate = $("input[name='hotelrate']").val();

  // 计算工作时间
  var hours = getSignHours(sDay,timein,timeout);

  $.each( idBox, function(i, n){
    var staffid = $(n).val();
    var name = $(n).parent().parent().find("[name='staffname']").text();
    var ic = $(n).parent().parent().find("[name='staffic']").text();
    if($("tr[staffid='"+staffid+"']").length == 0)
    {
      $("#staffList").append('<TR staffid="'+staffid+'" class="tdList" height="30"><TD style="text-align:center">'+(g_staff_num+1)+'</TD><TD>'+name+'</TD><TD>'+ic+'</TD><TD style="text-align:center"><input type="text" value="'+timein+'" name="staff_timein" style="width:40px;"></TD><TD style="text-align:center"><input type="text" name="staff_timeout" value="'+timeout+'" style="width:40px;"></TD><TD style="text-align:center"><input name="hours" type="text" value="'+hours+'" onkeydown="return false;" readOnly="readOnly" style="width:40px;"></TD><TD style="text-align:center"><input type="text" value="'+hotelrate+'" style="width:40px;" name="staff_hotelrate"></TD><TD style="text-align:center"><input type="text" value="0" onfocus="this.select()" staffid="'+staffid+'" style="width:40px;" onkeydown="keyStaffRate(this)" name="staffrate"></TD><TD style="text-align:center"><input type="button" class="but2" value="Delete" onclick="doDelete('+staffid+')"><input type="hidden" name="staffid" value="'+staffid+'"><input type="hidden" name="row_timein" value="'+g_time_in+'"><input type="hidden" name="row_timeout" value="'+g_time_out+'"></TD></TR>');
      g_staff_num++;
    }

  });
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
function doSearch(page)
{
  var where = getWhere("frmQry");
  showHint("Data Loading...");
  $("#staffList_s").load("StaffList_s.asp?page=" + page + "&txtWhere=" + EncodeUtf8(where),{},function(){
    hideHint();
  });

}

function doSearchAll()
{
  showHint("Data Loading...");
  $("#staffList_s").load("StaffList_s.asp?page=1&txtWhere=",{},function(){
    hideHint();
  });
}

function doReCalHours()
{
  var sDay = formatDate2Str($("input[name='signdate']").val());

  var idBox = $("tr[staffid]");
  $.each( idBox, function(i, n){
    var timein = $(n).find("input[name='staff_timein']").val();
    var timeout = $(n).find("input[name='staff_timeout']").val();
    var hours = getSignHours(sDay,timein,timeout);
    $(n).find("[name='hours']").val(hours);
    $(n).find("[name='row_timein']").val(g_time_in);
    $(n).find("[name='row_timeout']").val(g_time_out);
    
  });
  
  $("#hint").text("The calculation is complete");
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

  var obj = $("input[name='signdate']");

  obj.val(formatDate2Str(obj.val()));

  // 
  doReCalHours();

  if(!error) {
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
          location.href="sign_list.asp";
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
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <form style="margin:0px;" action="make_sign_save.asp" method="post" id="base-form">
    <TABLE width="100%" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Attendance Key-In
      <label id="hint" class="hint_red" style="font-size:9pt;font-weight:normal;padding-left:450px;">&nbsp;</label>
      </TD>
    </TR>
    <TR>
      <TD style="padding-bottom:10px;padding-top:10px;">
        
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right">Date:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="signdate" onfocus="return SelectDate(this,'dd/MM/yyyy')"><label class="hint_red">*</label></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD width="120px" align="right">Job Order:</TD>
              <TD width="200px">&nbsp;<input type="text" class="f-input" name="joborder"><label class="hint_red">*</label></TD>
            </TR>
            <TR height="30">
              <TD align="right">Time in:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="timein"><label class="hint_red">*</label></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Time out:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="timeout"><label class="hint_red">*</label></TD>
            </TR>

            <TR height="30">
              <TD align="right">Hotel Name:</TD>
              <TD>&nbsp;
        <select name="hotelname" style="width:155px">
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
        </select><label class="hint_red">*</label>

              </TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Hotel rate:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="hotelrate"></TD>
              </TD>
            </TR>
            <TR height="30">
              <TD align="right">Venue Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="venuename"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Attention:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="attention"></TD>
              <TD align="left" style="padding-left:10px;"><input type="button" onclick="checkBaseData()" value="Add Staff" class="but">
              <input type="hidden" name="addstaff" value="Add Staff">
              <input type="hidden" name="staffnum" value="">

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
        <TABLE class="sList" cellpadding="0" cellspacing="0" id="staffList">
          <TR class="title" height="30">
            <TD width="30">No.</TD>
            <TD width="130">Staff Name</TD>
            <TD width="180">Staff IC</TD>
            <TD width="50">Time in</TD>
            <TD width="50">Time out</TD>
            <TD width="40">Hours</TD>
            <TD width="60">Hotel Rate</TD>
            <TD width="60">Staff Rate</TD>
            <TD width="70">Delete</TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;" style="padding-left:500px;">
      
        <input type="button" value="Calculate hours" class="but" onclick="doReCalHours()">&nbsp;&nbsp;&nbsp;
        <input type="button" value="Save" class="but2" onclick="doSave()">
      </TD>
    </TR>
  </TABLE>

  </form>

    </td>
  </tr>
</table>


<div id="winDiv" style="display:none">
  <form style="margin:0px;" action="" method="post" id="frmQry">
    <TABLE cellpadding="0" cellspacing="0">
      <TR height="30">
        <TD align="right">Name:</TD>
        <TD>&nbsp;<input type="text" class="f-input" name="name" style="width:180px" operation="like"></TD>
        <TD>&nbsp;&nbsp;</TD>
        <TD width="120px" align="right">IC:</TD>
        <TD width="200px">&nbsp;<input type="text" class="f-input" name="ic" style="width:180px" operation="like"></TD>
      </TR>
      <TR height="30">
        <TD align="right">Main Hotel:</TD>
        <TD>&nbsp;
        <select name="mainhotel" style="width:180px">
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
        <TD colspan="3">&nbsp;<input type="button" class="but2" value="Search" onclick="doSearch(1)">&nbsp;
        <input type="button" class="but2" value="All" onclick="doSearchAll()">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="but" value="Add to list" onclick="addToList()">
        </TD>
      </TR>
    </TABLE>
  </form>
  <div style="height:400px;width:640px;overflow-x:hidden;overflow-y:auto;" id="staffList_s">
  <TABLE class="sList" cellpadding="0" cellspacing="0">
    <TR class="title" height="30">
      <TD width="30"><input type="checkbox" name="selectAll"></TD>
      <TD width="130">Staff Name</TD>
      <TD width="180">Staff IC</TD>
      <TD width="75">Nationality</TD>
      <TD width="80">HP No</TD>
      <TD width="120">School</TD>
      <TD width="*">Address</TD>
    </TR>
  </TABLE>
  </div>
</div>
</body>
</html>