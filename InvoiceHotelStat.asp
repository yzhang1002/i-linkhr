<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<%
signid = Request("signid")
sql = "select * from sign_base where signid=" & signid
set sig_rs = GetRecordSet(sql)


sql = "select * from customer where cusname='" & sig_rs("hotelname") & "'"
set cus_rs = GetRecordSet(sql)

sql = "select * from company where id=1"
set com_rs = GetRecordSet(sql)

%>
<html>
<head>
<title>I-LINKHR Management System Invoice Hotel</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
function doPrint()
{
  $("#print").hide();
  window.print();
  $("#print").show();
}

//-->
</SCRIPT>
</head>
<body>
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <TABLE width="700" align="center" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <TABLE cellpadding="0" cellspacing="0" width="700px" align="left">
          <TR>
            <TD align="left" colspan="2" height="40" valign="top"><img src="upload/<%=com_rs("logo")%>"></TD>
            <TD valign="bottom" style="font-size:10pt;font-weight:bold;">&nbsp;Invoice No.: <%=sig_rs("joborder")%></TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;"><%=com_rs("cname")%></TD>
            <TD align="left" style="font-size:10pt;font-weight:bold;"></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;"><%=com_rs("address")%></TD>
            <TD align="left" style="font-size:10pt;font-weight:bold;">Customer Name: <%=cus_rs("cusname")%></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;">Tel: <%=com_rs("tel")%></TD>
            <TD align="left" style="font-size:10pt;font-weight:bold;"><%=cus_rs("address")%></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;">Fax: <%=com_rs("fax")%></TD>
            <TD align="left" style="font-size:10pt;font-weight:bold;">Account No: <%=cus_rs("accountno")%></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;">Email: <%=com_rs("email")%></TD>
            <TD align="left" style="font-size:10pt;font-weight:bold;">Terms of Payment: <%=cus_rs("termpay")%></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD style="font-size:10pt;font-weight:bold;" colspan="2">Company Registration No: <%=com_rs("regno")%></TD>
            <TD>&nbsp;</TD>
          </TR>


        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD style="border-bottom:1px solid #000000;"></TD>
    </TR>

    <TR>
      <TD style="padding-top:5px;">

        <TABLE cellpadding="0" width="700" cellspacing="0" align="center">
          <TR height="30">
            <TD style="text-align:left;" style="font-size:14pt;font-weight:bold;">WorKingDate: &nbsp;&nbsp;&nbsp;&nbsp; <%=formatDate2En(sig_rs("signdate"))%>
            </TD>
            <TD style="text-align:right;" style="font-size:14pt;font-weight:bold;">
            BillingDate: 
            <%
            If sig_rs("billingdate") = "" Or IsNull(sig_rs("billingdate")) Then
              Response.Write formatDate2En(Now())
            Else
              Response.Write formatDate2En(sig_rs("billingdate"))
            End If
            %>
            </TD>
          </TR>
        </TABLE>
        <TABLE class="sListW" cellpadding="0" cellspacing="0" align="center" width="700">
          <TR class="title" height="30">
            <TD width="20">No.</TD>
            <TD width="120">Name</TD>
            <TD width="40">Sex</TD>
            <TD width="*">Identification No</TD>
            <TD width="60">Time in</TD>
            <TD width="65">Time out</TD>
            <TD width="40">Rate</TD>
            <TD width="50">Hours</TD>
            <TD width="50">Break</TD>
            <TD width="100">Amount SGD</TD>
          </TR>

<%

        sql = "select a.*,b.name,b.ic,b.gender from sign_list a,staff b,sign_base c where a.signid=c.signid and a.staffid=b.staffid and c.signid=" & signid & " order by a.timein , b.name"

        set rs = GetRecordSet(sql)

        i = 0
        total = 0
        hours = 0
        breaks = 0
        If (Not rs.eof) And (Not rs.bof) Then
          Do While (Not rs.eof) And (Not rs.bof) 
            i = i+1
%>
      <TR class="tdList" height="30">
          <TD style="text-align:center"><%=i%></TD >
          <TD>&nbsp;<%=formatSpChar2Nor(rs("name"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("gender"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("ic"))%></TD>
          <TD style="text-align:center"><%=formatDate2Time(rs("timein"))%></TD>
          <TD style="text-align:center"><%=formatDate2Time(rs("timeout"))%></TD>
          <TD style="text-align:center"><%=formatMoney(rs("hotelrate"))%></TD>
          <TD style="text-align:center"><%=formatMoney(rs("hours"))%></TD>
          <TD style="text-align:center"><%=formatMoney(rs("break"))%></TD>
          <TD style="text-align:center"><%=formatMoney(rs("amount"))%></TD>
        </TR>
<%
            hours = hours + rs("hours") - rs("break")
            breaks = breaks+rs("break")
            total = total + rs("amount")
            rs.MoveNext
          Loop
        End If
        rs.Close
        Set rs = Nothing

%>



        </TABLE>

        <TABLE cellpadding="0" width="700" cellspacing="0" align="center">
          <TR height="30">
            <TD style="padding-left:500px" colspan="10" width="100%"  style="font-size:13pt;font-weight:bold;">
              <font color="#AABF31"><%=formatMoney(hours)%></font>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <font color="#AABF31"><%=formatMoney(breaks)%></font>
            </TD>
          </TR>
        </TABLE>

        <TABLE cellpadding="0" width="700" cellspacing="0" align="center">
          <TR height="30">
            <TD style="text-align:right;" colspan="10" width="100%"  style="font-size:13pt;font-weight:bold;">Total:&nbsp;&nbsp;<font color="#AABF31"><%=formatMoney(total)%></font>&nbsp;&nbsp;</TD>
          </TR>
          <TR height="30">
            <TD style="text-align:right;" colspan="10" width="100%"  style="font-size:13pt;font-weight:bold;">Amount Payable:&nbsp;&nbsp;<font color="#AABF31"><%=formatMoney(total)%></font>&nbsp;&nbsp;</TD>
          </TR>
          <TR height="30">
            <TD style="text-align:left;" style="font-size:13pt;font-weight:bold;">FOR I-LINKHR PTE LTD</TD>
          </TR>
          <TR height="50">
            <TD>&nbsp;</TD>
          </TR>

          <%
          If sig_rs("chequeinfo") <> "" Then
          %>
          <TR height="30">
            <TD width="260">________________________________&nbsp;</TD>
            <TD style="text-align:left;" style="font-size:10pt;border-top:1px solid #000000;">
            <%=formatSpChar2Nor(sig_rs("chequeinfo"))%>
            </TD>
          </TR>
          <%
          Else
          %>
          <TR height="30">
            <TD width="260">________________________________&nbsp;</TD>
          </TR>
          <%
          End If
          %>
        </TABLE>

      </TD>
    </TR>
    <TR height="30">
      <TD>&nbsp;</TD>
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


<%
sig_rs.Close
Set sig_rs = Nothing
cus_rs.Close
Set cus_rs = Nothing
com_rs.Close
Set com_rs = Nothing
%>
</body>
</html>