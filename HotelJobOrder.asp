<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->
<%
signid = Request("signid")
sql = "select * from sign_base where signid=" & signid
set sig_rs = GetRecordSet(sql)

sql = "select * from customer where cusname='" & sig_rs("hotelname") & "'"
set cus_rs = GetRecordSet(sql)
cusname = cus_rs("cusname")

sql = "select * from company where id=1"
set com_rs = GetRecordSet(sql)

%>
<html>
<head>
<title>I-LINKHR Management System Hotel Job Order</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/css.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.timer.js"></script>
<script language="JavaScript" type="text/javascript" src="js/WebCalendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<script language=javascript>
<!--
$(document).ready(function(){
});

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
    <td >
    <TABLE width="700" align="center" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="padding-top:10px;padding-bottom:10px;">
        <TABLE cellpadding="0" cellspacing="0" width="700px" align="center">
        <TR>
          <TD colspan="2"><img src="upload/<%=com_rs("logo")%>"></TD>
          <TD valign="bottom" align="right" style="font-size:10pt;font-weight:bold;">Job Order : <%=sig_rs("joborder")%></TD>
        </TR>
        <TR>
          <TD width="300">

            <TABLE cellpadding="0" cellspacing="0" align="left">
              <TR>
                <TD style="font-size:10pt;font-weight:bold;"><%=com_rs("cname")%></TD>
              </TR>
              <TR>
                <TD style="font-size:10pt;font-weight:bold;"><%=com_rs("address")%></TD>
              </TR>
              <TR>
                <TD style="font-size:10pt;font-weight:bold;">Tel : <%=com_rs("tel")%></TD>
              </TR>
              <TR>
                <TD style="font-size:10pt;font-weight:bold;">Fax : <%=com_rs("fax")%></TD>
              </TR>
              <TR>
                <TD style="font-size:10pt;font-weight:bold;">Email :<%=com_rs("email")%></TD>
              </TR>
              <TR>
                <TD style="font-size:10pt;font-weight:bold;">Company Registration No : <%=com_rs("regno")%></TD>
              </TR>
            </TABLE>

          
          </TD>
          <TD>&nbsp;&nbsp;</TD>
          <TD>

            <TABLE cellpadding="0" cellspacing="0" align="center">
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;">Customer Name : <%=cus_rs("cusname")%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;"><%=cus_rs("address")%></TD>
                <TD>&nbsp;</TD>
              </TR>
              
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;">Attention : <%=cus_rs("attention")%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;">Venue Name : <%=sig_rs("venuename")%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;">Account No: <%=cus_rs("accountno")%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD align="left" style="font-size:10pt;font-weight:bold;">Terms of Payment: <%=cus_rs("termpay")%></TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          
          </TD>
        </TR>
        </TABLE>
        
      </TD>
    </TR>
    <TR>
      <TD ></TD>
    </TR>

    <TR>
      <TD style="padding-top:5px;">

        <TABLE cellpadding="0" width="700" cellspacing="0" align="center">
          <TR height="30">
            <TD style="text-align:left;" style="font-size:13pt;font-weight:bold;">ATTENDANCE</TD>
            <TD style="text-align:right;" style="font-size:13pt;font-weight:bold;">WorKingDate: <%=formatDate2En(sig_rs("signdate"))%></TD>
          </TR>
        </TABLE>
        <TABLE class="sListW" cellpadding="0" cellspacing="0" align="center" width="700">
          <TR class="title" height="30">
            <TD width="20">No.</TD>
            <TD width="120">Name</TD>
            <TD width="30">Sex</TD>
            <TD width="*">Identification No</TD>
            <TD width="60">Time In</TD>
            <TD width="80">Sign In</TD>
            <TD width="70">Time Out</TD>
            <TD width="80">Sign Out</TD>
            <TD width="80">Remark</TD>
          </TR>

<%
        sql = "select a.*,b.name,b.ic,b.gender from sign_list a,staff b,sign_base c where a.signid=c.signid and a.staffid=b.staffid and c.hotelname='" & cusname & "' and a.signid=" & signid & " order by a.timein,b.name"

        set rs = GetRecordSet(sql)
        i = 0
        If (Not rs.eof) And (Not rs.bof) Then
          Do While (Not rs.eof) And (Not rs.bof) 
            i = i+1
%>
      <TR class="tdList" height="30">
          <TD style="text-align:center"><%=i%></TD>
          <TD><%=formatSpChar2Nor(rs("name"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("gender"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("ic"))%></TD>
          <TD style="text-align:center"><%=formatDate2Time(rs("timein"))%></TD>
          <TD>&nbsp;</TD>
          <TD style="text-align:center"><%=formatDate2Time(rs("timeout"))%></TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
        </TR>
<%
            rs.MoveNext
          Loop
        End If
        rs.Close
        Set rs = Nothing

%>

        </TABLE>

        <TABLE cellpadding="0" width="700" cellspacing="0" align="center">
          <TR height="60">
            <TD style="text-align:left;" style="font-size:13pt;font-weight:bold;">FOR I-LINKHR PTE LTD</TD>
            <TD style="text-align:right;" style="font-size:13pt;font-weight:bold;padding-right:170px">CHECKED BY</TD>
          </TR>
          <TR height="30">
            <TD style="text-align:right;" colspan="10" width="100%"  style="font-size:13pt;font-weight:bold;">_______________&nbsp;&nbsp;</TD>
          </TR>
          <TR height="60">
            <TD colspan="2" style="text-align:right;" style="font-size:13pt;font-weight:bold;padding-right:170px">CHOP & SIGN</TD>
          </TR>
          <TR height="30">
            <TD style="text-align:right;" colspan="10" width="100%"  style="font-size:13pt;font-weight:bold;">_______________&nbsp;&nbsp;</TD>
          </TR>
        </TABLE>

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