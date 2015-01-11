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
$(document).ready(function(){
  getDataList();
});

var m_page = 1;
var m_where = "";
function getDataList()
{
  showHint("Data Loading...");
  $("#dataList").load("sign_list_inc.asp?page=" + m_page + "&txtWhere=" + m_where,{},function(){
    hideHint();
  });
}


function setPage(sPage)
{
  m_page = sPage;
  getDataList();
}

function doDel(sSignID)
{
  if(confirm("Are you sure to delete the sign information?"))
  {

    $.ajax({ 
      url: "sign_deal.asp", 
      data: "op=2&signid=" + sSignID,
      type:"post",
      dataType: "text",
      success: function(msg){
        if(msg == "")
        {
          alert("Delete successfully.");
          setPage(1);
        }
        else
        {
          alert("Delete failed.");
        }
      }
    });


  }
}

function doQuery()
{
  var obj = $("input[name='signdate']");
  var signdate = obj.val();

  obj.val(formatDate2Str(obj.val()));

  var where = getWhere("query-form");
  m_where = EncodeUtf8(where);
  obj.val(signdate);
  getDataList();
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
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Attendance List</TD>
    </TR>
    <TR>
      <TD style="padding-bottom:10px;padding-top:10px;">
        <form style="margin:0px;" action="" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
           <TR height="30">
              <TD align="right">Date:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="signdate" datatype="3" onfocus="return SelectDate(this,'dd/MM/yyyy')"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD width="120px" align="right">Job Order:</TD>
              <TD width="200px">&nbsp;<input type="text" class="f-input" name="joborder"></TD>
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
                </select>

              </TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Venue Name:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="venuename"></TD>
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
      <TD style="padding-top:5px;"><input type="button" class="but" id="addnew" name="addnew" value="Add New" onclick="location.href='sign_add.asp'">&nbsp;&nbsp;&nbsp;&nbsp;
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



</body>
</html>