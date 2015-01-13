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
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" type="text/javascript" src="js/WebCalendar.js"></script>

<script language=javascript>
<!--
var g_html = "";
var m_page = 1;
var m_where = "";

var tmp_page = "<%=Request("page")%>";
var tmp_where = "<%=Request("txtWhere")%>";

$(document).ready(function(){
  g_html = $("#winDiv").html();
  $("#winDiv").html("");
  // Ã· æ≤„
  $("input[name='excel']").qtip(
  {
     content: {
        text: g_html,
        title: {
           text: "Import Staff Excel ",
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
        width: 420 // Set the tooltip width
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

  // ’⁄’÷≤„
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

});


$(document).ready(function(){
  if(tmp_page!=''&&tmp_where!='')
  {
    m_page = tmp_page;
    m_where = EncodeUtf8(tmp_where);
  }
  getDataList();
});

function getDataList()
{
  showHint("Data Loading...");
  $("#dataList").load("StaffList.asp?page=" + m_page + "&txtWhere=" + m_where,{},function(){
    hideHint();
  });
}


function setPage(sPage)
{
  m_page = sPage;
  getDataList();
}

function doDel(sStaffID,cpage)
{
  if(confirm("Are you sure to delete the staff information?"))
  {
    showHint("Data Processing...");
    $.ajax({ 
      url: "staff_deal.asp", 
      data: "op=2&staffid=" + sStaffID,
      type:"post",
      dataType: "text",
      success: function(msg){
        if(msg == "")
        {
          alert("Delete successfully.");
          setPage(cpage);
        }
        else
        {
          alert("Delete failed.");
        }
        hideHint();
      }
    });


  }
}

function doQuery()
{
  var where = getWhere("query-form");
  var joindatestr = getJoinDateStr();
  if(where!=""||joindatestr!=""){
    if(where==""){
        where  = joindatestr;
    }
    else if(joindatestr==""){

    }
    else{
        where  = where + " AND " +joindatestr;
    }
  }
  m_where = EncodeUtf8(where);
  getDataList();
}

function getJoinDateStr(){
  var joindatestr = "";
  var fdatestr = "#2000-01-01#";
  var tdatestr = "#2100-12-31#";
  if($("#fdate").val()!=""||$("#tdate").val()!=""){
    if($("#fdate").val()!=""){
      fdatestr = "#"+$("#fdate").val()+"#";
    }
    else if($("#tdate").val()!=""){
      tdatestr = "#"+$("#tdate").val()+"#";
    }
    joindatestr = "join_date between "+fdatestr+" AND "+tdatestr;
  }
  return joindatestr;
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
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Staff List</TD>
    </TR>
    <TR>
      <TD style="padding-bottom:10px;padding-top:10px;">
        <form style="margin:0px;" action="" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD align="right">Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="name" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD width="120px" align="right">Customer Name:</TD>
              <TD width="200px">&nbsp;<input type="text" class="f-input" name="cusname" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">IC:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="ic" operation="like"></TD>
            </TR>
            <TR height="30">
              <TD align="right">Passport No:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="passport" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">HP NO:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="hpno" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Home NO:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="homeno" operation="like"></TD>
            </TR>

            <TR height="30">
              <TD align="right">E-Mail:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="email" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Main Hotel:</TD>
              <TD>&nbsp;
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
            <TR height="30">
              <TD align="right"><b>Join date:</b></TD>
            </TR>
            <TR height="30">
              <TD align="right">From:</TD>
              <TD>&nbsp;<input type="text" class="f-input" id="fdate" name="fdate" ignore="true" onfocus="return SelectDate(this,'yyyy-MM-dd')"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">To:</TD>
              <TD>&nbsp;<input type="text" class="f-input" id="tdate" name="tdate" ignore="true" onfocus="return SelectDate(this,'yyyy-MM-dd')"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD colspan="2">&nbsp;<input type="button" class="but2" id="query" name="query" value="Query" onclick="doQuery()">
              
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
      <TD style="padding-top:5px;"><input type="button" class="but" id="addnew" name="addnew" value="Add New" onclick="location.href='staff_input.asp'">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="but" id="excel" name="excel" value="Import Excel">
      </TD>
    </TR>

    <TR>
      <TD style="padding-top:5px;" id="dataList">

      </TD>
    </TR>

    </TABLE>





    </td>
  </tr>
</table>




<div id="winDiv" style="display:none">
  <form style="margin:0px;" action="upExcel.asp" method="post" id="frmFile"  enctype="multipart/form-data">
    <TABLE cellpadding="0" cellspacing="0">
      <TR height="30">
        <TD align="right">Excel:</TD>
        <TD>&nbsp;<INPUT TYPE="file" name="fileExcel"></TD>
        <TD>&nbsp;&nbsp;</TD>
        <TD width="200px">&nbsp;
        <input type="submit" class="but" value="Import Excel" >
        </TD>
      </TR>
    </TABLE>
  </form>

</div>


</body>
</html>