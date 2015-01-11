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

<SCRIPT LANGUAGE="JavaScript">


function doDel(sId)
{
  if(confirm("Are you sure to delete the admin information?"))
  {

    $.ajax({ 
      url: "sysadmin_deal.asp", 
      data: "op=2&id=" + sId,
      type:"post",
      dataType: "text",
      success: function(msg){
        if(msg == "")
        {
          alert("Delete successfully.");
          location.href = "sysadmin.asp";
        }
        else
        {
          alert("Delete failed.");
        }
      }
    });


  }
}

</SCRIPT>
</head>
<body>
<table cellpadding="0" cellspacing="0" width="100%" border="0" align="left" style="margin-top:10px;">
  <tr>
    <td style="padding-left:10px;">
    <TABLE width="100%" cellpadding="0" cellspacing="0">
    <TR>
      <TD style="border-bottom:1px solid #C4D5E0;font-size:16pt;font-weight:bold;">System Admin List</TD>
    </TR>
    <TR height="30">
      <TD align="left" style="padding-left:0px" colspan="2"><input type="button" class="but" id="addnew" name="addnew" value="Add New" onclick="location.href='sysadmin_input.asp'"></TD>
      </TD>
    </TR>
    <TR>
      <TD id="dataList">
      <TABLE class="sList" cellpadding="0" cellspacing="0">
        <TR class="title" height="30">
          <TD width="50">No.</TD>
          <TD width="130">User Name</TD>
          <TD width="180">Right</TD>
          <TD width="70">Operation</TD>
        </TR>

<%
        sql = "select * from [admin] order by [id]"

        set rs = GetRecordSet(sql)
        i = 0
        If (Not rs.eof) And (Not rs.bof) Then
          Do While (Not rs.eof) And (Not rs.bof) 
            i = i+1
%>
        <TR class="tdList" height="30">
          <TD><%=i%></TD>
          <TD>&nbsp;&nbsp;<%=rs("admin")%></TD>
          <TD style="text-align:center"><%=rs("admin_right")%></TD>
          <TD style="text-align:center"><a href="sysadmin_input.asp?id=<%=rs("id")%>" class="channel">Edit</a> / <a href="#" class="channel" onclick="doDel('<%=rs("id")%>')">Delete</a></TD>
        </TR>
<%
            rs.MoveNext
          Loop
        End If
        rs.Close
        Set rs = Nothing

%>


      </TABLE>
      </TD>
    </TR>

    </TABLE>





    </td>
  </tr>
</table>


</body>
</html>