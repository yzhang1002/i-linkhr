<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<%
staffid = Request("staffid")
fdate = Request("fdate")
tdate = Request("tdate")


set sta_rs = GetRecordSet("select staffid,name,gender,ic from staff where staffid=" & staffid)

%>
<html>
<head>
<title>I-LINKHR Management System Payment Voucher</title>
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
function doPrint()
{
  $("#print").hide();
  window.print();
  $("#print").show();
}


function doPaid()
{

  var idBox = $("td[pkid='y']");
  if(idBox.length == 0)
  {
    alert("No Data!");
    return "";
  }
  var idArray = new Array();
  var staffidArray = new Array();

  $.each( idBox, function(i, n){
    idArray.push($(n).attr("signid"));
    staffidArray.push($(n).attr("staffid"));
  });
  var signid = idArray.join(",");
  var staffid = staffidArray.join(",");

  showHint("Data Processing...");

  $.ajax({
    url: "paymentPaid.asp" ,
    data: "signid=" + signid + "&staffid=" + staffid,
    type:"post",
    dataType: "text",
    success: function(msg){
      if(msg == "")
      {
        alert("Data submit successfully.");
        location.href = "PaymentVoucher.asp?staffid=<%=staffid%>&fdate=<%=fdate%>&tdate=<%=tdate%>";
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
    <TABLE width="800" align="center" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;" align="center">Payment Voucher</TD>
    </TR>
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <TABLE cellpadding="0" cellspacing="0" width="800px" align="center">
          <TR height="30">
            <TD colspan="6" align="right" style="font-size:14pt;font-weight:bold;">
             &nbsp;<%=formatSpChar2Nor(Request("remark"))%>
            </TD>
          </TR>
          <TR>
            <TD align="right" style="font-size:14pt;font-weight:bold;" width="30">Name:</TD>
            <TD style="font-size:14pt;font-weight:bold;">&nbsp;<%=sta_rs("name")%></TD>
            <TD style="font-size:14pt;font-weight:bold;" align="right">Form:</TD>
            <TD style="font-size:14pt;font-weight:bold;">&nbsp;<%=Request("fdate")%></TD>
            <TD style="font-size:14pt;font-weight:bold;" align="right">To:</TD>
            <TD style="font-size:14pt;font-weight:bold;">&nbsp;<%=Request("tdate")%></TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;"></TD>
    </TR>

    <TR>
      <TD style="padding-top:5px;">


        <TABLE class="sListW" cellpadding="0" width="800" cellspacing="0" align="center">
          <TR class="title" height="30">
            <TD width="20">No.</TD>
            <TD width="80">Name</TD>
            <TD width="40">Sex</TD>
            <TD width="80">IC No</TD>
            <TD width="*">Hotel</TD>
            <TD width="70">Date</TD>
            <TD width="100">Working Time</TD>
            <TD width="40">Rate</TD>
            <TD width="50">Hours</TD>
            <TD width="60">Amount</TD>
			<TD></TD>
          </TR>


<%

        ' sql = "select a.*,b.hotelname from sign_list a,sign_base b where a.signid=b.signid and a.staffid=" & staffid & " and format(a.timeout,'yyyy-mm-dd')>=CDate('" & enDate2Str(fdate) & "') and format(a.timeout,'yyyy-mm-dd')<=CDate('" & enDate2Str(tdate) & "')"
        
        sql = "select a.*,b.hotelname from sign_list a,sign_base b where a.signid=b.signid and staffid=" & staffid & " and a.timein between #" & enDate2Str(fdate) & " 00:01# and #" & enDate2Str(tdate) & " 23:59# order by a.timein"
        
        ' Response.Write sql

        set rs = GetRecordSet(sql)
        ' Response.Write rs.recordCount
        i = 0
        total = 0
        color = "#000000"
        If (Not rs.eof) And (Not rs.bof) Then
          Do While (Not rs.eof) And (Not rs.bof) 
            i = i+1
            If ( Not IsNull(rs("paid")) ) Then
              If (CStr(rs("paid"))="1") Then color="red"
            End If
%>
      <TR class="tdList" height="30">
          <TD style="text-align:center" pkid="y" signid="<%=rs("signid")%>" staffid="<%=rs("staffid")%>"><%=i%></TD >
          <TD>&nbsp;<%=formatSpChar2Nor(sta_rs("name"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(sta_rs("gender"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(sta_rs("ic"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("hotelname"))%></TD>
          <TD style="text-align:center"><%=formatDate2En(rs("timein"))%></TD>
          <TD style="text-align:center"><%=formatDate2Time(rs("timein"))%>--<%=formatDate2Time(rs("timeout"))%></TD>
          <TD style="text-align:center;color:<%=color%>"><%=formatSpChar2Nor(rs("staffrate"))%></TD>
          <TD style="text-align:center;color:<%=color%>"><%=rs("hours") - rs("break")%></TD>
          <TD style="text-align:center;color:<%=color%>"><%=Round((rs("hours") - rs("break"))*rs("staffrate"),2)%></TD>
		  <TD><a target="_blank" href='/sign_edit_3.asp?signid=<%=rs("signid")%>&staffid=<%=rs("staffid")%>'>Edit Rate</a></TD>
        </TR>
<%
            total = total + Round((rs("hours")-rs("break"))*rs("staffrate"),2)
            rs.MoveNext
          Loop
        End If
        rs.Close
        Set rs = Nothing

%>


        </TABLE>

        <TABLE cellpadding="0" width="800" cellspacing="0" align="center">
          <TR height="30">
            <TD style="text-align:right;" colspan="2" width="100%"  style="font-size:14pt;font-weight:bold;">Total:&nbsp;&nbsp;<font color="#AABF31"><%=total%></font>&nbsp;&nbsp;</TD>
          </TR>
          <TR height="30">
            <TD style="text-align:left;" style="font-size:14pt;font-weight:bold;">Check By:&nbsp;&nbsp;__________&nbsp;&nbsp;</TD>
            <TD style="text-align:right;" style="font-size:14pt;font-weight:bold;">Receive By:&nbsp;&nbsp;__________&nbsp;&nbsp;</TD>
          </TR>

        </TABLE>

      </TD>
    </TR>

    </TABLE>
      <TABLE width="100%" id="print">
      <TR>
        <TD align="center">
        <input type="button" value="Paid All" class="but2" onclick="doPaid()">
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="Print" class="but2" onclick="doPrint()"></TD>
      </TR>
      </TABLE>

    </td>
  </tr>
</table>


<%
sta_rs.Close
Set sta_rs = Nothing
%>
</body>
</html>