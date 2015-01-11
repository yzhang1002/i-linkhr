<%@ Language=VBScript%>
<!--#include file="conn.asp"-->

      <TABLE class="sList" cellpadding="0" cellspacing="0">
        <TR class="title" height="30">
          <TD width="20">No.</TD>
          <TD width="80">Sign Date</TD>
          <TD width="100">Job Order</TD>
          <TD width="120">View</TD>
          <TD width="120">Edit</TD>
        </TR>
<%
cusname = Request("hotelname")
fdate = Request("fdate")
tdate = Request("tdate")

sql = "select distinct signid,signdate,joborder from sign_base where hotelname='" & cusname & "' and signdate between #" & enDate2Str(fdate) & "# and #" & enDate2Str(tdate) & "# order by signdate desc,joborder"

set rs = GetRecordSet(sql)
i = 0
If (Not rs.eof) And (Not rs.bof) Then

  Do While (Not rs.eof) And (Not rs.bof) 
    i = i + 1
%>

        <TR class="tdList" height="30">
          <TD style="text-align:center"><%=i%></TD >
          <TD style="text-align:center"><%=formatDate2En(rs("signdate"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("joborder"))%></TD>
          <TD style="text-align:center"><a target="_blank" href="InvoiceHotelStat.asp?signid=<%=rs("signid")%>&fdate=<%=fdate%>&tdate=<%=tdate%>" class="channel">View Invoice for Hotel</a></TD>
          <TD style="text-align:center"><a class="channel" href="sign_edit_2.asp?signid=<%=rs("signid")%>">Edit</a></TD>
        </TR>

<%
    rs.MoveNext
  Loop
End If

%>
    <tr>
      <td >&nbsp;
      </td>
   </tr>

  </table>
<%
rs.close
Set rs = Nothing
%>
