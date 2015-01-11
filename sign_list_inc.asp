<%@ Language=VBScript%>
<!--#include file="conn.asp"-->

      <TABLE class="sList" cellpadding="0" cellspacing="0">
        <TR class="title" height="30">
          <TD width="20">No.</TD>
          <TD width="50">Date</TD>
          <TD width="70">Job Order</TD>
          <TD width="50">Time in</TD>
          <TD width="50">Time out</TD>
          <TD width="145">Hotel Name</TD>
          <TD width="*">Venue Name</TD>
          <TD width="*">Attention</TD>
          <TD width="60">Staff nums</TD>
          <TD width="70">Operation</TD>
        </TR>
<%
strWhere = Request("txtWhere")
If strWhere <> "" Then
  strWhere = " where " & strWhere
End If

sql = "select * from sign_base " & strWhere & " order by signdate desc ,signid desc"

' Response.Write sql
' Response.End

set rs = GetRecordSet(sql)
i = 0
If (Not rs.eof) And (Not rs.bof) Then
  rs.movefirst
  rs.PageSize=30
  Page=CLng(Request("page"))
  If Page<1 Then Page=1
  If Page>rs.PageCount Then Page=rs.PageCount
  
  rs.AbsolutePage=Page

  For iPage=1 To rs.PageSize
    i = i + 1
%>

      <TR class="tdList" height="30">
          <TD style="text-align:center"><%=i%></TD >
          <TD style="text-align:center"><%=formatDate2En(rs("signdate"))%></TD>
          <TD style="text-align:center"><a href="HotelJobOrder.asp?signid=<%=rs("signid")%>" target="_blank" class="channel"><%=formatSpChar2Nor(rs("joborder"))%></a></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("timein"))%></TD>
          <TD style="text-align:center"><%=formatSpChar2Nor(rs("timeout"))%></TD>
          <TD><%=formatSpChar2Nor(rs("hotelname"))%></TD>
          <TD><%=formatSpChar2Nor(rs("venuename"))%></TD>
          <TD><%=formatSpChar2Nor(rs("attention"))%></TD>
          <TD style="text-align:center">&nbsp;<%=formatSpChar2Nor(rs("staffnum"))%></TD>
          <TD style="text-align:center"><a href="sign_edit.asp?signid=<%=formatSpChar2Nor(rs("signid"))%>" class="channel">Edit</a> / <a href="#" onclick="doDel('<%=formatSpChar2Nor(rs("signid"))%>')" class="channel">Delete</a></TD>
        </TR>

<%
    rs.MoveNext
    If rs.Eof Then Exit For
  Next
End If

%>
    <tr>
      <td >&nbsp;
      </td>
   </tr>

    <tr>
      <td align="right" colspan="16" style="border-right:1px solid #ffffff;">&nbsp;
        <%
        If Page<>1 Then
           %>
           <a href="#" onclick="setPage(1)">[First Page]</a>
          <a href="#" onclick="setPage(<%=Page-1%>)">[Pre Page]</a>
        <%
        End if
        If Page<>rs.pageCount Then
        %>
           <a href="#" onclick="setPage(<%=Page+1%>)">[Next Page]</a>
           <a href="#" onclick="setPage(<%=rs.PageCount%>)">[Last Page]</a>
           <%
        End If
        %>
        Page:<font color="red"><%=Page%></font>/<font color="blue"><%=rs.PageCount%></font>

      </td>
   </tr>
  </table>
<%
rs.close
Set rs = Nothing
%>
