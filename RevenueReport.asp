<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<%
fdate = Request("fdate")
tdate = Request("tdate")
hotelname = Request("hotelname")
%>
<html>
<head>
<title>I-LINKHR Management System Revenue Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<script language=javascript>
<!--
function doPrint()
{
  $("#print").hide();
  window.print();
  $("#print").show();
}


-->
</script>

</head>
<body>
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <TABLE width="400" align="center" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;" align="center">Revenue Report</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <TABLE cellpadding="0" cellspacing="0" width="400px" align="center">
          <TR>
            <TD style="font-size:12pt;font-weight:bold;" align="left">Form:</TD>
            <TD style="font-size:12pt;font-weight:bold;">&nbsp;<%=Request("fdate")%></TD>
            <TD style="font-size:12pt;font-weight:bold;" align="right">To:</TD>
            <TD style="font-size:12pt;font-weight:bold;">&nbsp;<%=Request("tdate")%></TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;"></TD>
    </TR>

    <TR>
      <TD style="padding-top:5px;">

<%
If hotelname = "" Then
  sql = "select sum(amount) as turnover,sum(staffrate*(hours-break)) as expenditure from sign_list where timeout between #" & enDate2Str(fdate) & " 00:01# and #" & enDate2Str(tdate) & " 23:59#"
Else
  sql = "select sum(amount) as turnover,sum(staffrate*(hours-break)) as expenditure from sign_list where timeout between #" & enDate2Str(fdate) & " 00:01# and #" & enDate2Str(tdate) & " 23:59# and signid in (select signid from sign_base where hotelname='" & hotelname & "')"

End If
set rs = GetRecordSet(sql)

If (Not rs.eof) And (Not rs.bof) And (Not IsNull(rs("turnover"))) Then
%>
        <TABLE class="sList" cellpadding="0" width="400" cellspacing="0" align="center">
          <TR class="title" height="30">
            <TD>Turnover</TD>
            <TD>Expenditure</TD>
            <TD>Profit</TD>
          </TR>
          <TR class="tdList" height="30">
            <TD style="font-size:12pt;color:#AABF31;text-align:center"><%=Round(rs("turnover"),2)%></TD>
            <TD style="font-size:12pt;color:#AABF31;text-align:center"><%=Round(rs("expenditure"),2)%></TD>
            <TD style="font-size:12pt;color:#AABF31;text-align:center"><%=Round(rs("turnover")-rs("expenditure"),2)%></TD>
          </TR>

        </TABLE><BR><BR>
<%
End If
rs.Close
Set rs = Nothing
%>
      </TD>
    </TR>

    </TABLE>
      <TABLE width="100%" id="print">
      <TR>
        <TD align="center"><input type="button" value="Print" class="but2" onclick="doPrint()"></TD>
      </TR>
      </TABLE>

    </td>
  </tr>
</table>



</body>
</html>