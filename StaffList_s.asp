<%@ Language=VBScript%>
<!--#include file="conn.asp"-->

      <TABLE class="sList" cellpadding="0" cellspacing="0">
        <TR class="title" height="30">
          <TD width="20"><input type="checkbox" name="selectAll" onclick="selectAll_S(this)"></TD>
          <TD width="80">Name</TD>
          <TD width="80">IC NO.</TD>
          <TD width="75">Nationality</TD>
          <TD width="80">HP No</TD>
          <TD width="120">School</TD>
          <TD width="*">Address</TD>
          <TD width="80">Date of Birth</TD>
        </TR>
<%
strWhere = Request("txtWhere")
If strWhere <> "" Then
  strWhere = " where " & strWhere
End If

sql = "select * from staff " & strWhere & " order by name"

set rs = GetRecordSet(sql)
i = 0
If (Not rs.eof) And (Not rs.bof) Then
  rs.movefirst
  rs.PageSize=50
  Page=CLng(Request("page"))
  If Page<1 Then Page=1
  If Page>rs.PageCount Then Page=rs.PageCount
  
  rs.AbsolutePage=Page

  For iPage=1 To rs.PageSize
    i = i + 1
%>

      <TR class="tdList" height="30">
          <TD style="text-align:center"><input type="checkbox" name="wait_staffid" value="<%=formatSpChar2Nor(rs("staffid"))%>"></TD >
          <TD name="staffname"><%=formatSpChar2Nor(rs("name"))%></TD>
          <TD name="staffic" style="text-align:center"><%=formatSpChar2Nor(rs("ic"))%></TD>
          <TD><%=formatSpChar2Nor(rs("nationality"))%></TD>
          <TD><%=formatSpChar2Nor(rs("hpno"))%></TD>
          <TD><%=formatSpChar2Nor(rs("school"))%></TD>
          <TD><%=formatSpChar2Nor(rs("address"))%></TD>
          <TD style="text-align:center"><%=formatDate2En(rs("birthday"))%></TD>
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
           <a href="#" onclick="doSearch(1)">[First Page]</a>
          <a href="#" onclick="doSearch(<%=Page-1%>)">[Pre Page]</a>
        <%
        End if
        If Page<>rs.pageCount Then
        %>
           <a href="#" onclick="doSearch(<%=Page+1%>)">[Next Page]</a>
           <a href="#" onclick="doSearch(<%=rs.PageCount%>)">[Last Page]</a>
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
