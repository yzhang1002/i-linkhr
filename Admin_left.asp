
<html>
<head>
<style type=text/css>
body  { background:#799AE1; margin:0px; font:normal 12px; 
SCROLLBAR-FACE-COLOR: #799AE1; SCROLLBAR-HIGHLIGHT-COLOR: #799AE1; 
SCROLLBAR-SHADOW-COLOR: #799AE1; SCROLLBAR-DARKSHADOW-COLOR: #799AE1; 
SCROLLBAR-3DLIGHT-COLOR: #799AE1; SCROLLBAR-ARROW-COLOR: #FFFFFF;
SCROLLBAR-TRACK-COLOR: #AABFEC;
}
table  { border:0px; }
td  { font:normal 12px ; }
img  { vertical-align:bottom; border:0px; }
a  { font:normal 12px ; color:#215DC6; text-decoration:none; }
a:hover  { color:#428EFF;text-decoration: underline; }
.sec_menu  { border-left:1px solid white; border-right:1px solid white; border-bottom:1px solid white; 
  background:#D6DFF7; padding:5px 2px;}
.menu_title  { }
.menu_title span  { position:relative; top:2px; left:8px; color:#215DC6; font-weight:bold; }
.menu_title2  { }
.menu_title2 span  { position:relative; top:2px; left:8px; color:#428EFF; font-weight:bold; }

</style>
<script language=javascript>
function menuChange(obj,menu)
{
	if(menu.style.display=="")
	{
		obj.background="images/admin_title_bg_hide.gif";
		menu.style.display="none";
	}else{
		obj.background="images/admin_title_bg_show.gif";
		menu.style.display="";
	}
}

function proLoadimg()
{
	var i=new Image;
	i.src='images/admin_title_bg_hide.gif';
	i.src='images/admin_title_bg_show.gif';
}
proLoadimg();
</script>
</head>
<body>
<%
If instr(Session("right"),"1") <> 0 Then
%>
<br>
<table cellpadding=0 cellspacing=0 width=158 align=center style="display: ">
  <tr style="cursor:hand;">
    <td height=25 class="menu_title" background="images/admin_title_bg_show.gif" onmouseover="this.className='menu_title2';" onmouseout="this.className='menu_title';"> 
      <span><a href="sysadmin.asp" target=right>System Admin</a></span> </td>
  </tr>
</table>
<%
End If
%>
<%
If instr(Session("right"),"2") <> 0 Then
%>
<br>
<table cellpadding=0 cellspacing=0 width=158 align=center style="display: ">
  <tr style="cursor:hand;">         
      
    <td height=25 class="menu_title" background="images/admin_title_bg_show.gif" onmouseover="this.className='menu_title2';" onmouseout="this.className='menu_title';" onclick="menuChange(this,menu12);"> 
      <span>Basic Info.</span> </td>
  </tr>
  <tr>
    <td>
      <div class=sec_menu id=menu12 style="display: ">
        <table cellpadding=0 cellspacing=0 align=center width=140 height="40">
          <tr height="20"> 
            <td height="18" align="left"><a href="staff_input.asp" target="right">Staff management</a></td>
          </tr>
          <tr height="20"> 
            <td height="18" align="left"><a href="staff.asp" target="right">Master List</a></td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<%
End If
%>
<%
If instr(Session("right"),"3") <> 0 Then
%>
<br>
<table cellpadding=0 cellspacing=0 width=158 align=center style="display: ">
  <tr style="cursor:hand;">
    <td height=25 class="menu_title" background="images/admin_title_bg_show.gif" onmouseover="this.className='menu_title2';" onmouseout="this.className='menu_title';" onclick="menuChange(this,menu13);"> 
      <span>Operation Dept.</span> </td>
  </tr>
  <tr>
    <td>
      <div class=sec_menu id="menu13" style="display: ">
        <table cellpadding=0 cellspacing=0 align=center width=140 height="40">
          <tr height="20">
            <td align="left" height="18"><a href="sign_add.asp" target="right">Attendance Key-In</a></td>
          </tr>
          <tr height="20"> 
            <td height="18" align="left"><a href="sign_list.asp" target="right">Attendance List </a></td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<%
End If
%>
<%
If instr(Session("right"),"4") <> 0 Then
%>
<br>
<table cellpadding=0 cellspacing=0 width=158 align="center" style="display: ">
  <tr style="cursor:hand;">
    <td height=25 class="menu_title" background="images/admin_title_bg_show.gif" onmouseover="this.className='menu_title2';" onmouseout="this.className='menu_title';" onclick="menuChange(this,menu14);"> 
      <span>Finance Dept.</span> </td>
  </tr>
  <tr>
    <td>
      <div class=sec_menu id="menu14" style="display: ">
        <table cellpadding=0 cellspacing=0 align=center width=140 height="40">
          <tr height="20">
            <td height="18" align="left"><a href="invoice_hotel.asp" target="right">Hotel Invoice </a></td>
          </tr>
          <tr height="20">
            <td align="left" height="18"><a href="pament_staff.asp" target="right">Staff Payment</a></td>
          </tr>
          <tr height="20">
            <td align="left" height="18"><a href="customer.asp" target="right">Client Info.</a></td>
          </tr>
          <tr height="20">
            <td align="left" height="18"><a href="company.asp" target="right">Company Info.</a></td>
          </tr>
          <tr height="20"> 
            <td height="18" align="left"><a href="revenue.asp" target="right">Revenue Report</a></td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>

<%
End If
%>
<br>


<table cellpadding=0 cellspacing=0 width=158 align="center" style="display: ">
  <tr style="cursor:hand;">
    <td height=25 class="menu_title" background="images/admin_title_bg_show.gif" onmouseover="this.className='menu_title2';" onmouseout="this.className='menu_title';" onclick="menuChange(this,menu6);"> 
      <span>Copyright</span> </td>
  </tr>
  <tr>
    <td>
      <div class=sec_menu id=menu6 style="display: ">
        <table cellpadding=0 cellspacing=0 align=center width=140>
          <tr height=20>
            <td>I-LINKHR</td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<br><br>

</body>
</html>