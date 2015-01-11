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
  $("#dataList").load("CustomerList.asp?page=" + m_page + "&txtWhere=" + m_where,{},function(){
    hideHint();
  });
}


function setPage(sPage)
{
  m_page = sPage;
  getDataList();
}

function doDel(sCusId)
{
  if(confirm("Are you sure to delete the customer information?"))
  {

    $.ajax({ 
      url: "customer_deal.asp", 
      data: "op=2&cusid=" + sCusId,
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
  var where = getWhere("query-form");
  m_where = EncodeUtf8(where);
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
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">Customer List</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <form action="" style="margin:0px" method="post" id="query-form">
          <TABLE cellpadding="0" cellspacing="0">
            <TR height="30">
              <TD width="120px" align="right">Customer Name:</TD>
              <TD width="200px">&nbsp;<input type="text" class="f-input" name="cusname" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Account No:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="accountno" operation="like"></TD>
              <TD>&nbsp;&nbsp;</TD>
              <TD align="right">Tel:</TD>
              <TD>&nbsp;<input type="text" class="f-input" name="tel" operation="like"></TD>
            </TR>
            <TR height="30">
              <TD align="left" style="padding-left:20px" colspan="2"><input type="button" class="but" id="addnew" name="addnew" value="Add New" onclick="location.href='customer_input.asp'"></TD>
              <TD colspan="8" align="right">&nbsp;<input type="button" class="but2" id="query" name="query" value="Query" onclick="doQuery()">
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
<!--
      <TABLE class="sList" cellpadding="0" cellspacing="0">
        <TR class="title" height="30">
          <TD width="50">Invoice No.</TD>
          <TD width="130">Customer Name</TD>
          <TD width="180">Customer Address</TD>
          <TD width="75">Tel</TD>
          <TD width="75">Fax</TD>
          <TD width="45">Account No</TD>
          <TD width="110">Email</TD>
          <TD width="55">Terms of Payment</TD>
          <TD width="70">Registration No</TD>
          <TD width="70">Operation</TD>
        </TR>
        <TR class="tdList" height="30">
          <TD>Inc00171</TD>
          <TD>Intercontinental Singapore</TD>
          <TD>80 Middle Road,Singapore 188966</TD>
          <TD>(65) 64028315</TD>
          <TD>(65) 63963586</TD>
          <TD style="text-align:center">P/009</TD>
          <TD>operation@i-linkhr.com</TD>
          <TD style="text-align:center">14 Days</TD>
          <TD style="text-align:center">200614661W</TD>
          <TD style="text-align:center"><a href="" class="channel">Edit</a> / <a href="#" class="channel">Delete</a></TD>
        </TR>
      </TABLE>
-->
      </TD>
    </TR>

    </TABLE>





    </td>
  </tr>
</table>



</body>
</html>